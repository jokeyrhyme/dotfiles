#! /usr/bin/env -S deno run --allow-run

// keep open for 10 seconds by default
setTimeout(() => {
  Deno.exit(0);
}, 10e3);

async function main(): Promise<void> {
  const config = await getConfig();
  const directives = parseSwayConfig(config);
  const keysToActions = mapKeysToActions(mapActionsToKeys(directives));

  const keybindings = Array.from(keysToActions.keys()).sort();
  const longestKeys = keybindings.reduce(
    (prev, curr) => Math.max(prev, curr.length),
    0,
  );

  for (const keybinding of keybindings) {
    console.log(`${keybinding.padEnd(longestKeys)} -> ${keysToActions.get(keybinding)}`);
  }
}

enum SwayCommand {
  BindSym = 'bindsym',
}

interface SwayDirective {
  command: string[];
  keys: string;
  sway: SwayCommand;
}

async function getConfig(): Promise<string> {
  const rawSwayConfigBytes = await Deno.run({
    cmd: ["swaymsg", "--raw", "--type", "get_config"],
    stdout: "piped",
  }).output();

  const stdout = (new TextDecoder().decode(rawSwayConfigBytes) || "").trim();
  return JSON.parse(stdout).config;
}

function mapActionsToKeys(config: SwayDirective[] = []): Map<string, string[]> {
  const results = new Map();

  for (const { command, keys, sway } of config) {
    if (sway !== SwayCommand.BindSym) {
      continue; // not a keybinding, exclude it
    }

    const action = command.join(" ");
    const keybindings = results.get(action) || [];

    keybindings.push(keys);

    results.set(action, keybindings);
  }

  return results;
}

function mapKeysToActions(actionsToKeys: Map<string, string[]>): Map<string, string> {
  const results = new Map();

  for (const [ action, keybindings ] of actionsToKeys.entries()) {
    results.set(keybindings.join(' OR '), action);
  }

  return results;
}

function parseSwayConfig(text: string = ""): SwayDirective[] {
  const results: SwayDirective[] = [];

  let isBlock = false;
  let sway;
  for (let line of text.split("\n")) {
    line = line.trim();

    if (line.startsWith("#")) {
      continue; // don't bother processing comments for now
    }

    const parts = line.split(/\s+/).filter(Boolean);
    const ending = parts[parts.length - 1];

    if (ending === "{") {
      isBlock = true;
      sway = parts[0];
      continue;
    }
    if (ending === "}") {
      isBlock = false;
      sway = null;
      continue;
    }

    if (isBlock && sway) {
      parts.unshift(sway);
    }

    if (parts[0] === SwayCommand.BindSym && parts.length >= 3) {
      const [sway, keys, ...command] = parts;
      results.push({
        command,
        keys,
        sway,
      });
    }
  }

  return results;
}

if (import.meta.main) {
  main().catch((err) => {
    console.error(err);
    Deno.exit(1);
  });
}
