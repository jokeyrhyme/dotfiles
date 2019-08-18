#!/bin/sh

if command -v pacman >/dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy atom apm
fi
