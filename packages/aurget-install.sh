#!/bin/sh

if which pacman > /dev/null 2>&1; then
  echo 'preparing ArchLinux for AUR aurget...'
  sudo pacman -S --needed abs base-devel
  sudo mkdir -p /var/abs/local
  sudo chmod -R g+w /var/abs/local
  sudo chown -R root:wheel /var/abs/local

  echo 'installing AUR aurget...'
  URL=https://raw.githubusercontent.com/stuartpb/aur.sh/master/aur.sh
  curl $URL | BUILDDIR=/var/abs/local bash -si aurget

  # curl https://aur.archlinux.org/cgit/aur.git/snapshot/aurget.tar.gz | bsdtar xf - && cd aurget && makepkg -sicf && cd .. && rm -rf aurget/
fi
