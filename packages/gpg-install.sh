#! /usr/bin/env sh

set -e

pushd "$(dirname $0)/.." >/dev/null
. ./scripts/lib/is.sh
popd >/dev/null

if command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y gnupg2
  sudo dnf install -y https://prerelease.keybase.io/keybase_amd64.rpm
fi

if command -v pacaur >/dev/null 2>&1; then
  sudo pacman -Sy --needed --noconfirm perl-xml-parser
fi

if __dotfiles_is_homebrew_found; then
  brew install gpg2
fi

if command -v pacaur >/dev/null 2>&1; then
  pacaur -Sy --needed --noconfirm keybase-bin
fi

pushd "$(dirname $0)/.." >/dev/null
. ./packages/gpg-update.sh
popd >/dev/null
