#!/bin/sh

set -e

pushd "$(dirname $0)/.." >/dev/null
. ./scripts/lib/is.sh
popd >/dev/null

if __dotfiles_is_homebrew_found; then
  echo 'found brew! preferring brew-installed git'
  brew install mercurial
  exit 0
fi

if which hg >/dev/null 2>&1; then
  echo 'found git! no install necessary'
  exit 0
fi

if which pacman >/dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy --needed --noconfirm mercurial
  exit 0
fi

if which dnf >/dev/null 2>&1; then
  echo 'found dnf!'
  sudo dnf install -y mercurial
  exit 0
fi

if which yum >/dev/null 2>&1; then
  echo 'found yum!'
  sudo yum install -y mercurial
  exit 0
fi

if which apt >/dev/null 2>&1; then
  echo 'found apt!'
  apt-get install -y mercurial
  exit 0
fi
