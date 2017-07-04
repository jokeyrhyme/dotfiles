#!/bin/sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/is.sh
. ./scripts/lib/utils.sh
popd > /dev/null

__dotfiles_assert_in_path ruby
__dotfiles_assert_in_path git
__dotfiles_assert_in_path xcode-select

if __dotfiles_is_homebrew_found; then
  echo 'found brew! no install necessary'
  exit 0
fi

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap caskroom/cask

pushd "$(dirname $0)/.." > /dev/null
. ./packages/homebrew-update.sh
popd > /dev/null
