#! /usr/bin/env sh

set -e

pushd "$(dirname $0)/.." >/dev/null
. ./scripts/lib/utils.sh
popd >/dev/null

if command -v pacman >/dev/null 2>&1; then
  echo 'installing toolchain with pacman ...'
  sudo pacman -S --needed --noconfirm base-devel cmake expac kcov lldb yajl

  #  echo 'installing / updating AUR pacaur ...'
  #  __dotfiles_ensure_shallow_git_clone ~/.pacaur-repo https://github.com/rmarquis/pacaur.git
  #  sudo cp -v ~/.pacaur-repo/pacaur /usr/local/bin/pacaur
  #  sudo chmod a+rx /usr/local/bin/pacaur

  echo 'updating packages with pacman ...'
  sudo pacman -Su --needed archlinux-keyring
  sudo pacman -Syu

  echo 'installing favourites with pacman ...'
  sudo pacman -S --needed --noconfirm bash fish gnupg lynis neofetch tmux zsh
  sudo pacman -S --needed --noconfirm pandoc # needed for checkmake # TODO: haskell?
  sudo pacman -S --needed --noconfirm adobe-source-{code,sans,serif}-pro-fonts noto-fonts{,-emoji} otf-overpass ttf-{cascadia-code,fira-{code,mono,sans},hack,jetbrains-mono} inter-font
  # TODO: try to keep in sync with config/Brewfile

#  if command -v pacaur >/dev/null 2>&1; then
#    echo 'updating packages with pacaur...'
#    pacaur -Syu --aur
#  fi
fi
