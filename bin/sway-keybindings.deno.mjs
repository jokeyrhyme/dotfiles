#! /usr/bin/env -S deno run --allow-run

// keep open for 10 seconds by default
setTimeout(() => {
  Deno.exit(0);
}, 10e3);

// main entrypoint
(async () => {
  const config = await getConfig();
  const keybindings = parseSwayConfig(config).filter(({ sway }) =>
    sway === "bindsym"
  );
  console.log(`${keybindings.length} keybindings:`);
  console.log(formatKeybindings(keybindings));
})().catch((err) => {
  console.error(err);
  //Deno.exit(1);
});

function formatKeybindings(config = []) {
  const longestKeys = config.reduce(
    (prev, curr) => Math.max(prev, curr.keys.length),
    0,
  );
  return config.map(({ command, keys }) =>
    `${keys.padEnd(longestKeys)} -> ${command.join(" ")}`
  ).join("\n");
}

async function getConfig() {
  const rawSwayConfigBytes = await Deno.run({
    cmd: ["swaymsg", "--raw", "--type", "get_config"],
    stdout: "piped",
  }).output();

  const stdout = (new TextDecoder().decode(rawSwayConfigBytes) || "").trim();
  return JSON.parse(stdout).config;
}

function parseSwayConfig(text = "") {
  const results = [];

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

    if (parts[0] === "bindsym" && parts.length >= 3) {
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
