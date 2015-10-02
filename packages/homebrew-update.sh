#!/bin/sh

# set -e

if which brew > /dev/null 2>&1; then
  echo 'updating Homebrew and packages...'
  sudo chmod g+w /usr/local/share/zsh /usr/local/share/zsh/site-functions
  brew update && brew upgrade --all && brew linkapps && brew cleanup
  sudo chmod g-w /usr/local/share/zsh /usr/local/share/zsh/site-functions
fi

if which brew-cask.rb > /dev/null 2>&1; then
  echo 'updating Homebrew Cask and packages...'
  brew cask cleanup
fi
