#! /usr/bin/env sh

set -e

pushd "$(dirname $0)/.." >/dev/null
. ./scripts/lib/is.sh
popd >/dev/null

if command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y gnupg2
fi

if __dotfiles_is_homebrew_found; then
  brew install gpg2
fi

pushd "$(dirname $0)/.." >/dev/null
. ./packages/gpg-update.sh
popd >/dev/null
