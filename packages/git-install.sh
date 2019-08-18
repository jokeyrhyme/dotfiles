#!/bin/sh

set -e

pushd "$(dirname $0)/.." >/dev/null
. ./scripts/lib/is.sh
popd >/dev/null

if __dotfiles_is_homebrew_found; then
  echo 'found brew! preferring brew-installed git'

  sudo chmod g+w /usr/local/share/zsh /usr/local/share/zsh/site-functions

  brew install git git-crypt git-flow git-lfs

  sudo chmod g-w /usr/local/share/zsh /usr/local/share/zsh/site-functions
fi

if command -v pacman >/dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy --needed --noconfirm git
fi

if command -v dnf >/dev/null 2>&1; then
  echo 'found dnf!'
  sudo dnf install -y git

elif command -v yum >/dev/null 2>&1; then
  echo 'found yum!'
  sudo yum install -y git
fi

if command -v apt-get >/dev/null 2>&1; then
  echo 'found apt!'
  sudo apt-get install -y git
fi

if __dotfiles_is_linuxbrew_found; then
  brew install git-crypt git-flow git-lfs
fi

pushd "$(dirname $0)/.." >/dev/null
. ./packages/git-config.sh
popd >/dev/null
