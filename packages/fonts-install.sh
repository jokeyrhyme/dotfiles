#!/bin/sh

set -e

if type dnf > /dev/null 2>&1; then
  echo 'found dnf!'
  sudo dnf install -y adobe-source-{code,sans}-pro-fonts
  sudo dnf install -y google-droid-{sans,serif,sans-mono}-fonts
  sudo dnf install -y liberation-{mono,narrow,sans,serif}-fonts
fi

if type pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy --needed --noconfirm adobe-source-{code,sans,serif}-pro-fonts
  sudo pacman -Sy --needed --noconfirm ttf-{droid,liberation,ubuntu-font-family}
fi
