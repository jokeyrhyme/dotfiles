#!/bin/sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/is.sh
. ./scripts/lib/utils.sh
popd > /dev/null

if __dotfiles_is_homebrew_found; then
  echo 'found brew!'
  brew install ctags
  brew cask install --force macvim
fi

if which dnf > /dev/null 2>&1; then
  echo 'found dnf!'
  sudo dnf install -y ctags vim
  if which Xorg > /dev/null 2>&1; then
    echo 'found Xorg!'
    sudo dnf install -y vim-X11
  fi
fi

if which pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy --noconfirm ctags gvim
fi
