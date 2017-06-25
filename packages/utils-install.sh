#!/bin/sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/is.sh
popd > /dev/null

if __dotfiles_is_brew_found; then
  brew install awscli jq
  # having issues: bmon md5sha1sum
fi

if which pacman > /dev/null 2>&1; then
  sudo pacman -Sy --needed --noconfirm iptraf-ng
fi