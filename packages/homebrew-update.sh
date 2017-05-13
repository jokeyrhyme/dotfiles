#!/bin/sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/is.sh
popd > /dev/null

if __dotfiles_is_homebrew_found; then
  sudo chmod g+w /usr/local/share/zsh /usr/local/share/zsh/site-functions
fi

if __dotfiles_is_brew_found; then
  echo 'updating Homebrew and packages...'
  brew update && brew upgrade && brew cleanup
fi

if __dotfiles_is_homebrew_found; then
  sudo chmod g-w /usr/local/share/zsh /usr/local/share/zsh/site-functions
fi

if which brew-cask.rb > /dev/null 2>&1; then
  echo 'updating Homebrew Cask and packages...'
  brew cask cleanup
fi
