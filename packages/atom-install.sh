#!/bin/sh

if which pacman >/dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy atom apm
fi
