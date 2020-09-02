#! /usr/bin/env -S deno run --allow-run

/* eslint-env es2021 */
/*
 * reliably wire up wf-recorder to a v4l2 loopback device
 */ /* global Deno */ const DEFAULT_RUN_OPTIONS = {
  stdin: 'piped',
  stderr: 'piped',
  stdout: 'piped',
};
const V4L2_LOOPBACK_MODULE = 'v4l2loopback';
const WF_RECORDER_V4L2_NAME = 'WfRecorder';

// main entrypoint
(async () => {
  if (Deno.args.includes('start')) {
    return start();
  }

  if (Deno.args.includes('stop')) {
    return stop();
  }
})().catch((err) => {
  console.error(err);
  Deno.exit(1);
});

async function findWfRecorderDevicePath() {
  let wfRecorder = (await v4l2CtlListDevices()).find(
    ({ name }) => name === WF_RECORDER_V4L2_NAME,
  );
  if (!wfRecorder) {
    await modprobeV4l2loopback();
    wfRecorder = (await v4l2CtlListDevices()).find(
      ({ name }) => name === WF_RECORDER_V4L2_NAME,
    );
  }
  // TODO: handle the case where v4l2loopback is already used for something else
  return wfRecorder?.paths?.[0];
}

async function lsmod() {
  const out = await stdout(
    Deno.run({
      ...DEFAULT_RUN_OPTIONS,
      cmd: ['lsmod'],
    }),
  );
  return parseLsmod(out);
}

async function modprobeV4l2loopback() {
  const p = Deno.run({
    ...DEFAULT_RUN_OPTIONS,
    cmd: [
      'pkexec',
      'modprobe',
      V4L2_LOOPBACK_MODULE,
      'exclusive_caps=1',
      `card_label=${WF_RECORDER_V4L2_NAME}`,
    ],
  });
  await p.status();
  await sleep();
}

async function killallWfRecorder() {
  await Deno.run({
    ...DEFAULT_RUN_OPTIONS,
    cmd: ['killall', 'wf-recorder'],
  }).output();
}

function parseLsmod(stdout) {
  // e.g.
  // vfat                   24576  1
  // fat                    86016  1 vfat

  const modules = []; // {name, size}[]
  for (let line of stdout.split('\n')) {
    line = line.trim();
    const [, name, size] = line.match(/^(\w+)\s+(\d+)/) || [];
    if (name && size) {
      modules.push({ name, size: parseInt(size, 10) });
      continue;
    }
  }
  return modules;
}

function parseV4l2CtlListDevices(stdout) {
  // e.g.
  // WfRecorder (platform:v4l2loopback-000):
  //        /dev/video4

  const devices = []; // {id, name, paths}[]
  let record;
  for (let line of stdout.split('\n')) {
    line = line.trim();
    const [, name, id] = line.match(/^(.*) \((.*)\):$/) || [];
    if (name && id) {
      record = { id, name, paths: [] };
      devices.push(record);
      continue;
    }
    if (line.startsWith('/dev/')) {
      record.paths.push(line);
      continue;
    }
  }

  return devices;
}

async function rmmodV4l2loopback() {
  const p = Deno.run({
    ...DEFAULT_RUN_OPTIONS,
    cmd: ['pkexec', 'rmmod', V4L2_LOOPBACK_MODULE],
  });
  await p.output();
}

function sleep(ms = 500) {
  return new Promise((resolve) => {
    setTimeout(resolve, ms);
  });
}

async function start() {
  const devicePath = await findWfRecorderDevicePath();
  await wfRecorder(devicePath);
}

async function stop() {
  await killallWfRecorder();

  const loadedModules = await lsmod();
  if (loadedModules.some(({ name }) => name === V4L2_LOOPBACK_MODULE)) {
    await rmmodV4l2loopback();
  }
}

async function stdout(process) {
  return new TextDecoder().decode(await process.output());
}

async function v4l2CtlListDevices() {
  const out = await stdout(
    Deno.run({
      ...DEFAULT_RUN_OPTIONS,
      cmd: ['v4l2-ctl', '--list-devices'],
    }),
  );
  return parseV4l2CtlListDevices(out);
}

async function wfRecorder(devicePath) {
  await Deno.run({
    ...DEFAULT_RUN_OPTIONS,
    cmd: [
      'wf-recorder',
      '--muxer=v4l2',
      '--codec=rawvideo',
      `--file=${devicePath}`,
      '--pixel-format=yuv420p',
    ],
  }).status();
}
