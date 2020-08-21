#! /usr/bin/env sh

set -e

pushd "$(dirname $0)/.." >/dev/null
. ./scripts/lib/utils.sh
popd >/dev/null

if command -v pacman >/dev/null 2>&1; then
  sudo pacman -Su --needed --noconfirm archlinux-keyring

  echo 'installing favourites with pacman ...'

  # basics
  sudo pacman -S --needed --noconfirm alacritty bash fish lynis man-db neofetch neovim sudo tmux zsh

  # developer tools
  sudo pacman -S --needed --noconfirm base-devel cmake expac kcov lldb yajl
  sudo pacman -S --needed --noconfirm pandoc # needed for checkmake # TODO: haskell?
  sudo pacman -S --needed --noconfirm python-pipx shellcheck

  # encryption
  sudo pacman -S --needed --noconfirm gnupg keybase{,-gui} opensc pcsclite yubikey-manager

  # firmware and drivers
  sudo pacman -S --needed --noconfirm cups{,-filters,-pk-helper} foomatic-db-gutenprint-ppds fwupd linux-firmware pavucontrol

  # flatpak and friends
  sudo pacman -S --needed --noconfirm flatpak xdg-utils

  # swaywm and friends
  sudo pacman -S --needed --noconfirm gammastep grim light mako network-manager-applet playerctl polkit-gnome slurp sway{,bg,idle,lock} waybar wf-recorder wl-clipboard wofi

  # fonts
  sudo pacman -S --needed --noconfirm adobe-source-{code,sans,serif}-pro-fonts noto-fonts{,-emoji} otf-{font-awesome,overpass} ttf-{cascadia-code,fira-{code,mono,sans},hack,jetbrains-mono,roboto{,-mono}} inter-font

  if pacman -Q keybase-bin >/dev/null 2>&1; then
    sudo pacman -R --noconfirm --unneeded keybase-bin # from AUR, now in community
  fi
  if pacman -Q redshift >/dev/null 2>&1; then
    sudo pacman -R --noconfirm --unneeded redshift # doesn't work on wayland
  fi

  echo 'updating packages with pacman ...'
  sudo pacman -Syu
fi
