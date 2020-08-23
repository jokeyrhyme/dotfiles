#! /usr/bin/env sh

# check if kernel modules do not match kernel version,
# which often happens when `pacman -Syu` upgrades the kernel

# usage:
#  path/to/check-kernel-modules-match.sh [--json]

# options:
#  --json: output JSON for waybar, always with exit code 0

MSG_FAIL="mismatch! modules for current kernel version not found in /usr/lib/modules!"
MSG_PASS="/usr/lib/modules has modules for current kernel version"
VERSION=$(uname --kernel-release)
if [ -d "/usr/lib/modules/${VERSION}" ]; then
  if [ "$1" = "--json" ]; then
    echo '{"class": "success", "percentage": 100, "tooltip": ""}'
  else
    echo "${MSG_PASS}"
  fi
  exit 0
fi

if [ "$1" = "--json" ]; then
  echo "{\"class\": \"critical\", \"percentage\": 0, \"tooltip\": \"${MSG_FAIL}\"}"
  exit 0
fi

echo "${MSG_FAIL}"
exit 1

