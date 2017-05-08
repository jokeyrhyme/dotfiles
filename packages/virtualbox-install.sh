#!/bin/sh

set -e

if type brew > /dev/null 2>&1; then
  echo 'found brew!'

  sudo chmod g+w /usr/local/share/zsh /usr/local/share/zsh/site-functions

  brew cask install --force virtualbox virtualbox-extension-pack

  sudo chmod g-w /usr/local/share/zsh /usr/local/share/zsh/site-functions
fi

if type pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy --needed --noconfirm virtualbox virtualbox-host-dkms
fi
