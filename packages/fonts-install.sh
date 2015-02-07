#!/bin/sh

set -e

if type pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy --needed --noconfirm adobe-source-{code,sans,serif}-pro-fonts
  sudo pacman -Sy --needed --noconfirm ttf-{droid,liberation,ubuntu-font-family}
fi
