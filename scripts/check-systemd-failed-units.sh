#! /usr/bin/env sh

# check for any systemd failed units

# usage:
#  path/to/check-systemd-failed-units.sh [--json]

# options:
#  --json: output JSON for waybar, always with exit code 0

MSG_FAIL="systemd has units in failed state"
MSG_PASS="systemd has no units in failed state"

if systemctl list-units --state=failed | grep "0 loaded units listed" >/dev/null; then
  if [ "$1" = "--json" ]; then
    echo '{"class": "success", "percentage": 100, "tooltip": ""}'
  else
    echo "${MSG_PASS}"
  fi
  exit 0
fi

if [ "$1" = "--json" ]; then
  echo "{\"class\": \"warning\", \"percentage\": 0, \"tooltip\": \"${MSG_FAIL}\"}"
  exit 0
fi

echo "${MSG_FAIL}"
exit 1
