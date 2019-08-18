#!/bin/sh

set -e

if command -v flatpak >/dev/null 2>&1; then
  flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

  flatpak update
fi
