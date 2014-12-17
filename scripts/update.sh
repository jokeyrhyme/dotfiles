#!/bin/sh

if type yum > /dev/null 2>&1; then
  echo 'updating packages with yum...'
  sudo yum upgrade -y
fi

if type pacman > /dev/null 2>&1; then
  echo 'updating packages with pacman...'
  sudo pacman -Syu
fi

if type brew > /dev/null 2>&1; then
  echo 'updating Homebrew and packages...'
  brew update && DYLD_LIBRARY_PATH=/opt/homebrew/lib brew upgrade && brew linkapps && brew cleanup
fi

if type brew-cask.rb > /dev/null 2>&1; then
  echo 'updating Homebrew Cask and packages...'
  brew cask cleanup
fi

if type npm &> /dev/null; then
  echo 'updating NPM and packages...'
  npm -g update
fi

if type gem > /dev/null 2>&1; then
  echo 'updating Ruby gems...'
  gem update
  gem cleanup
fi

if type apm > /dev/null 2>&1; then
  echo 'updating Atom packages...'
  apm upgrade --confirm false
fi
