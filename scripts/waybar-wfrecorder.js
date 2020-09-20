#! /usr/bin/env -S deno run --allow-read

/* global Deno */
/*
 * waybar indicator to show if wf-recorder is running
 *
 * see: https://github.com/Alexays/Waybar/wiki/Module:-Custom
 *
 * TODO: use process events instead of polling
 * TODO: return tooltip with output file path or video device
 *
 */ /* eslint-env es2021 */ (async () => {
  // entrypoint
  if (await isProcessRunning("wf-recorder")) {
    console.log(
      JSON.stringify({
        class: "recording",
        percentage: 100,
        text: "wf-recorder",
      }),
    );
    return;
  }
  console.log(
    JSON.stringify({
      percentage: 0,
      text: "wf-recorder",
    }),
  );
})().catch((err) => {
  console.error(err);
  Deno.exit(1);
});

async function isProcessRunning(processName) {
  for await (const dirEntry of Deno.readDir("/proc")) {
    if (!dirEntry.isDirectory || !dirEntry.name.match(/^\d+$/)) {
      // not a process entry, skip
      continue;
    }
    try {
      const status = await Deno.readTextFile(`/proc/${dirEntry.name}/status`);
      for (let line of status.split("\n")) {
        line = line.trim();
        if (line.startsWith("Name:")) {
          let [, name] = line.split(":");
          name = name.trim();

          if (name === processName) {
            return true;
          }

          // not interested in anything else about this process
          break;
        }
      }
    } catch (err) {
      // race between readDir and readTextFile,
      // process is probably already gone
    }
  }
  return false;
}
