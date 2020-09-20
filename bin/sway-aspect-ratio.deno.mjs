#! /usr/bin/env -S deno run --allow-run

// main entrypoint
(async () => {
  if (Deno.args.includes("16:9")) {
    await set16By9Mode();
  } else if (Deno.args.includes("native")) {
    await setNativeMode();
  }
})().catch((err) => {
  console.error(err);
  Deno.exit(1);
});

function get16By9Mode({ modes = [] } = {}) {
  // assumption: the best 16:9 mode is the last 16:9 mode
  const matching = modes.filter(isMode16By9);
  return matching[matching.length - 1] || {};
}

async function getFocusedOutput() {
  const outputs = await getOutputs();
  return outputs.find(({ focused }) => focused);
}

function getNativeMode({ modes = [] } = {}) {
  return modes[modes.length - 1] || {};
}

async function getOutputs() {
  const rawSwayOutputsBytes = await Deno.run({
    cmd: ["swaymsg", "--raw", "--type", "get_outputs"],
    stdout: "piped",
  }).output();

  const stdout = (new TextDecoder().decode(rawSwayOutputsBytes) || "").trim();
  return JSON.parse(stdout);
}

function isMode16By9({ height = 0, width = 0 } = {}) {
  return height / 9 * 16 === width;
}

function isModeNative(output, { height = 0, width = 0 } = {}) {
  // assumption: the last mode contains the native resolution
  const nativeMode = getNativeMode(output);
  return nativeMode.height === height && nativeMode.width === width;
}

async function set16By9Mode() {
  const output = await getFocusedOutput();
  if (isMode16By9(output.current_mode)) {
    return; // already 16:9, do nothing
  }
  const { width, height } = get16By9Mode(output);
  await Deno.run({
    cmd: ["swaymsg", "output", output.name, "mode", `${width}x${height}`],
    stdout: "piped",
  }).output();
}

async function setNativeMode() {
  const output = await getFocusedOutput();
  if (isModeNative(output, output.current_mode)) {
    return; // already native aspect ratio, do nothing
  }
  const { width, height } = getNativeMode(output);
  await Deno.run({
    cmd: ["swaymsg", "output", output.name, "mode", `${width}x${height}`],
    stdout: "piped",
  }).output();
}
