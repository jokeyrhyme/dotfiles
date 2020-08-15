#! /usr/bin/env sh

set -e

pushd "$(dirname $0)/.." >/dev/null
. ./scripts/lib/utils.sh
popd >/dev/null

if command -v pacman >/dev/null 2>&1; then
  sudo pacman -Su --needed --noconfirm archlinux-keyring

  # TODO: try to keep in sync with config/Brewfile
  echo 'installing favourites with pacman ...'
  sudo pacman -S --needed --noconfirm base-devel cmake expac kcov lldb yajl
  sudo pacman -S --needed --noconfirm bash fish gnupg lynis neofetch tmux zsh
  sudo pacman -S --needed --noconfirm pandoc # needed for checkmake # TODO: haskell?
  sudo pacman -S --needed --noconfirm opensc yubikey-manager
  sudo pacman -S --needed --noconfirm alacritty keybase{,-gui} python-pipx neovim
  sudo pacman -S --needed --noconfirm sway swaybg swayidle swaylock waybar wofi
  sudo pacman -S --needed --noconfirm adobe-source-{code,sans,serif}-pro-fonts noto-fonts{,-emoji} otf-overpass ttf-{cascadia-code,fira-{code,mono,sans},hack,jetbrains-mono,roboto{,-mono}} inter-font
  if pacman -Q keybase-bin >/dev/null 2>&1; then
    sudo pacman -R --noconfirm --unneeded keybase-bin # from AUR, now in community
  fi
  if pacman -Q redshift >/dev/null 2>&1; then
    sudo pacman -R --noconfirm --unneeded redshift # doesn't work on wayland
  fi

  echo 'updating packages with pacman ...'
  sudo pacman -Syu
fi
