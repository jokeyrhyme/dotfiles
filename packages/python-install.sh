#!/usr/bin/env sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/is.sh
popd > /dev/null

if __dotfiles_is_brew_found; then
  brew install python python3
fi

pushd "$(dirname $0)/.." > /dev/null
. ./packages/python-update.sh
popd > /dev/null
