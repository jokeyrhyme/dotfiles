#! /usr/bin/env sh

set -e

pushd "$(dirname $0)/.." >/dev/null
. ./scripts/lib/utils.sh
popd >/dev/null

if which pacman >/dev/null 2>&1; then
  echo 'installing toolchain with pacman ...'
  sudo pacman -S --needed --noconfirm base-devel cmake expac kcov lldb yajl

  #  echo 'installing / updating AUR pacaur ...'
  #  __dotfiles_ensure_shallow_git_clone ~/.pacaur-repo https://github.com/rmarquis/pacaur.git
  #  sudo cp -v ~/.pacaur-repo/pacaur /usr/local/bin/pacaur
  #  sudo chmod a+rx /usr/local/bin/pacaur

  echo 'updating packages with pacman ...'
  sudo pacman -Su --needed archlinux-keyring
  sudo pacman -Syu

#  if which pacaur >/dev/null 2>&1; then
#    echo 'updating packages with pacaur...'
#    pacaur -Syu --aur
#  fi
fi
