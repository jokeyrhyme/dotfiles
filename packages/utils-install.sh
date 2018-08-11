#!/bin/sh

set -e

pushd "$(dirname $0)/.." >/dev/null
. ./scripts/lib/is.sh
popd >/dev/null

if which dnf >/dev/null 2>&1; then
  sudo dnf install -y iptraf-ng
fi

if __dotfiles_is_brew_found; then
  brew install awscli
  # having issues: bmon md5sha1sum
fi

if which pacman >/dev/null 2>&1; then
  sudo pacman -Sy --needed --noconfirm iptraf-ng
fi
