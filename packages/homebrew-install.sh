#!/bin/sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/utils.sh
popd > /dev/null

__dotfiles_assert_in_path ruby
__dotfiles_assert_in_path git
__dotfiles_assert_in_path xcode-select

if type brew > /dev/null 2>&1; then
  echo 'found brew! no install necessary'
  exit 0
fi

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew cask
