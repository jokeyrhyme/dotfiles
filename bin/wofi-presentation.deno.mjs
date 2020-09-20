#! /usr/bin/env -S deno run --allow-env --allow-run

// main entrypoint
(async () => {
  const items = new Map([
    ["wf-recorder -> v4l2loopback: start", [
      "swaymsg",
      "exec",
      "~/.dotfiles/scripts/wfrecorder-to-v4l2loopback.deno.mjs start",
    ]],
    ["wf-recorder -> v4l2loopback: start (region)", [
      "swaymsg",
      "exec",
      "~/.dotfiles/scripts/wfrecorder-to-v4l2loopback.deno.mjs start --slurp",
    ]],
    ["wf-recorder -> v4l2loopback: stop", [
      "swaymsg",
      "exec",
      "~/.dotfiles/scripts/wfrecorder-to-v4l2loopback.deno.mjs stop",
    ]],
  ]);
  if (Deno.env.get("XDG_SESSION_DESKTOP") === "sway") {
    items.set(
      "sway: aspect ratio: 16:9",
      [
        "swaymsg",
        "exec",
        "~/.dotfiles/bin/sway-aspect-ratio.deno.mjs 16:9",
      ],
    );
    items.set(
      "sway: aspect ratio: native",
      [
        "swaymsg",
        "exec",
        "~/.dotfiles/bin/sway-aspect-ratio.deno.mjs native",
      ],
    );
  }

  const p = Deno.run({
    cmd: ["wofi", "--show=dmenu"],
    stderr: "piped",
    stdin: "piped",
    stdout: "piped",
  });

  const bytes = new TextEncoder().encode(Array.from(items.keys()).join("\n"));
  await Deno.writeAll(p.stdin, bytes);
  p.stdin.close();

  const stdout = (new TextDecoder().decode(await p.output()) || "").trim();
  if (!stdout) {
    Deno.exit(0);
  }

  const cmd = items.get(stdout);
  if (!cmd) {
    throw new Error(`unexpected command key: "${stdout}"`);
  }

  await Deno.run({ cmd, stdout: "piped" }).output();
})().catch((err) => {
  console.error(err);
  Deno.exit(1);
});
