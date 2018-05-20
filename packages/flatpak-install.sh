#!/bin/sh

set -e

if which pacman >/dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy --needed --noconfirm flatpak
fi

if which dnf >/dev/null 2>&1; then
  echo 'found dnf!'
  sudo dnf install -y flatpak

elif which yum >/dev/null 2>&1; then
  echo 'found yum!'
  sudo yum install -y flatpak
fi

pushd "$(dirname $0)/.." >/dev/null
. ./packages/flatpak-update.sh
popd >/dev/null
