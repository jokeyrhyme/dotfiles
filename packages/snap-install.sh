#!/bin/sh

set -e

if command -v pacman >/dev/null 2>&1; then
  sudo pacman -Sy --needed --noconfirm snapd
fi

if command -v snap >/dev/null 2>&1; then
  if command -v systemctl >/dev/null 2>&1; then
    sudo systemctl enable snapd.service
    sudo systemctl start snapd.service

    sudo systemctl enable snapd.refresh.timer
    sudo systemctl start snapd.refresh.timer
  fi
fi

pushd "$(dirname $0)/.." >/dev/null
. ./packages/snap-update.sh
popd >/dev/null
