#!/bin/sh

set -eu

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/is.sh
. ./scripts/lib/utils.sh
popd > /dev/null

__dotfiles_assert_in_path brew

if __dotfiles_is_brew_found; then
  echo "installing Ruby via Homebrew..."
  brew install ruby
fi

pushd "$(dirname $0)/.." > /dev/null
. ./packages/ruby-update.sh
popd > /dev/null
