#! /usr/bin/env sh

set -e

__dotfiles_pacman_install() {
  # shellcheck disable=SC2068
  # explicitly passing arguments along without quoting
  sudo pacman -S --needed --noconfirm $@
}

__dotfiles_pacman_uninstall() {
  for PKG in "$@"; do
    if pacman -Q "${PKG}" >/dev/null 2>&1; then
      sudo pacman -R --noconfirm --unneeded "${PKG}"
    fi
  done
}

if command -v pacman >/dev/null 2>&1; then
  sudo pacman -Su --needed --noconfirm archlinux-keyring

  echo 'installing favourites with pacman ...'

  # basics
  __dotfiles_pacman_install alacritty bash deno fish linux{,-lts} man-db neofetch neovim tmux zsh

  # security
  __dotfiles_pacman_install arch-audit lynis nftables osquery sudo
  __dotfiles_pacman_install firewalld python-pyqt5 qt5-wayland # python/qt packages are needed for firewall-applet

  # developer tools
  __dotfiles_pacman_install base-devel cmake expac kcov lldb yajl
  __dotfiles_pacman_install linux{,-lts}-headers # needed for DKMS e.g. v4l2loopback
  __dotfiles_pacman_install pandoc               # needed for checkmake # TODO: haskell?
  __dotfiles_pacman_install python-pipx shellcheck

  # encryption
  __dotfiles_pacman_install gnupg keybase{,-gui} opensc pcsclite yubikey-manager

  # devices, firmware, and drivers
  __dotfiles_pacman_install cups{,-filters,-pk-helper} foomatic-db-gutenprint-ppds fwupd linux-firmware pavucontrol pipewire{,-jack,-pulse} usbutils v4l-utils v4l2loopback-dkms
  if /usr/bin/lsusb | /usr/bin/grep -i bluetooth >/dev/null 2>&1; then
    __dotfiles_pacman_install blueman bluez{,-utils} pulseaudio-bluetooth
  fi

  # flatpak and friends
  __dotfiles_pacman_install flatpak xdg-utils

  # swaywm and friends
  __dotfiles_pacman_install gammastep grim light mako network-manager-applet playerctl polkit-gnome slurp sway{,bg,idle,lock} waybar wf-recorder wl-clipboard wofi

  # fonts
  __dotfiles_pacman_install adobe-source-{code,sans,serif}-pro-fonts noto-fonts{,-emoji} otf-{font-awesome,overpass} ttf-{cascadia-code,fira-{code,mono,sans},hack,jetbrains-mono,roboto{,-mono}} inter-font

  echo 'uninstalling ex-favourites with pacman ...'

  __dotfiles_pacman_uninstall keybase-bin # from AUR, now in community
  __dotfiles_pacman_uninstall redshift    # doesn't work on wayland

  echo 'updating packages with pacman ...'
  sudo pacman -Syu
fi
