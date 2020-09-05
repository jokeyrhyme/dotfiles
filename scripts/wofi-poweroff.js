#! /usr/bin/env -S deno run --allow-env --allow-run

/* eslint-env es2021 */ /* global Deno */ (async () => {
  // main entrypoint
  const items = [
    'loginctl lock-session',
    'systemctl hibernate',
    'systemctl hybrid-sleep',
    'systemctl poweroff',
    'systemctl reboot',
    'systemctl suspend',
  ];
  // TODO: only add systemctl commands that definitely work
  if (Deno.env.get('XDG_SESSION_DESKTOP') === 'sway') {
    items.push('swaymsg exit');
  }
  items.sort();

  const p = Deno.run({
    cmd: ['wofi', '--show=dmenu'],
    stderr: 'piped',
    stdin: 'piped',
    stdout: 'piped',
  });

  const bytes = new TextEncoder().encode(items.join('\n'));
  await Deno.writeAll(p.stdin, bytes);
  p.stdin.close();

  const stdout = new TextDecoder().decode(await p.output());
  if (stdout) {
    const cmd = stdout.split(/\s/).filter(Boolean);
    await Deno.run({ cmd, stdout: 'piped' }).output();
  }
})().catch((err) => {
  console.error(err);
  Deno.exit(1);
});
