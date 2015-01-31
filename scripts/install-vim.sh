#!/bin/sh

set -e

if type brew > /dev/null 2>&1; then
  echo 'found brew!'
  brew install macvim
  exit 0
fi

if type pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy gvim-python3
  exit 0
fi
