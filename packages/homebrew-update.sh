#!/bin/sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/is.sh
popd > /dev/null

if __dotfiles_is_homebrew_found; then
  echo 'updating Homebrew and packages...'
  sudo chmod g+w /usr/local/share/zsh /usr/local/share/zsh/site-functions
  brew update && brew upgrade && brew cleanup
  sudo chmod g-w /usr/local/share/zsh /usr/local/share/zsh/site-functions
fi

if which brew-cask.rb > /dev/null 2>&1; then
  echo 'updating Homebrew Cask and packages...'
  brew cask cleanup
fi
