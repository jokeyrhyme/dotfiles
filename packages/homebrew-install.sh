#!/bin/sh

set -e

source $(dirname $0)/../scripts/lib/utils.sh

__dotfiles_assert_in_path ruby
__dotfiles_assert_in_path git
__dotfiles_assert_in_path xcode-select

if type brew > /dev/null 2>&1; then
  echo 'found brew! no install necessary'
  exit 0
fi

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew cask
