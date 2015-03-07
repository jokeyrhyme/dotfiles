#!/bin/sh

if type pacman > /dev/null 2>&1; then
  echo 'preparing ArchLinux for AUR atom-editor-bin...'
  sudo pacman -S --needed abs
  sudo mkdir -p /var/abs/local
  sudo chmod -R g+w /var/abs/local
  sudo chown -R root:wheel /var/abs/local

  echo 'installing AUR atom-editor-bin...'
  URL=https://aur.archlinux.org/packages/at/atom-editor-bin/atom-editor-bin.tar.gz
  DL=/var/abs/local/atom-editor-bin.tar.gz
  rm -fr /var/abs/local/atom-editor-bin/
  curl -o "$DL" "$URL"
  pushd /var/abs/local
  tar zxf "$DL"
  pushd /var/abs/local/atom-editor-bin/
  makepkg -s
  sudo pacman -U *.pkg.tar
  popd
fi
