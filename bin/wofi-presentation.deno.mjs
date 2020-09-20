#! /usr/bin/env -S deno run --allow-env --allow-run

// main entrypoint
(async () => {
  const items = {
    "wf-recorder -> v4l2loopback: start": [
      "swaymsg",
      "exec",
      "~/.dotfiles/scripts/wfrecorder-to-v4l2loopback.deno.mjs start",
    ],
    "wf-recorder -> v4l2loopback: start (region)": [
      "swaymsg",
      "exec",
      "~/.dotfiles/scripts/wfrecorder-to-v4l2loopback.deno.mjs start --slurp",
    ],
    "wf-recorder -> v4l2loopback: stop": [
      "swaymsg",
      "exec",
      "~/.dotfiles/scripts/wfrecorder-to-v4l2loopback.deno.mjs stop",
    ],
  };

  const p = Deno.run({
    cmd: ["wofi", "--show=dmenu"],
    stderr: "piped",
    stdin: "piped",
    stdout: "piped",
  });

  const bytes = new TextEncoder().encode(Object.keys(items).join("\n"));
  await Deno.writeAll(p.stdin, bytes);
  p.stdin.close();

  const stdout = new TextDecoder().decode(await p.output());
  if (stdout) {
    const cmd = items[stdout.trim()];
    await Deno.run({ cmd, stdout: "piped" }).output();
  }
})().catch((err) => {
  console.error(err);
  Deno.exit(1);
});
