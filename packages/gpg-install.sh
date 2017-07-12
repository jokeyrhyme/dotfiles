#! /usr/bin/env sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/is.sh
popd > /dev/null

if which pacaur > /dev/null 2>&1; then
  sudo pacman -Sy --needed --noconfirm perl-xml-parser
fi

if __dotfiles_is_brew_found; then
  brew install gpg2
fi

if which pacaur > /dev/null 2>&1; then
  pacaur -Sy --needed --noconfirm keybase-bin
fi

pushd "$(dirname $0)/.." > /dev/null
. ./packages/gpg-update.sh
popd > /dev/null
