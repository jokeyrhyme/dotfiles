#!/bin/sh

set -e

pushd "$(dirname $0)/.." >/dev/null
. ./scripts/lib/is.sh
popd >/dev/null

if __dotfiles_is_homebrew_found; then
  echo 'found brew!'

  sudo chmod g+w /usr/local/share/zsh /usr/local/share/zsh/site-functions

  brew cask install --force virtualbox virtualbox-extension-pack

  sudo chmod g-w /usr/local/share/zsh /usr/local/share/zsh/site-functions
fi

if which pacman >/dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy --needed --noconfirm virtualbox virtualbox-host-dkms
fi
