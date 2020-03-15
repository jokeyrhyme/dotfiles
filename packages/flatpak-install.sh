#! /usr/bin/env sh

set -e

if command -v pacman >/dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy --needed --noconfirm flatpak
fi

if command -v dnf >/dev/null 2>&1; then
  echo 'found dnf!'
  sudo dnf install -y flatpak

elif command -v yum >/dev/null 2>&1; then
  echo 'found yum!'
  sudo yum install -y flatpak
fi
