#!/bin/sh

set -e

if which flatpak > /dev/null 2>&1; then
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

  flatpak remote-add --if-not-exists gnome https://sdk.gnome.org/gnome.flatpakrepo
  flatpak remote-add --if-not-exists gnome-apps https://sdk.gnome.org/gnome-apps.flatpakrepo

  flatpak update
fi
