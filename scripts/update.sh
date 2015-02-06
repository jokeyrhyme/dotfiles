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
  brew update && brew upgrade && brew linkapps && brew cleanup
fi

if type brew-cask.rb > /dev/null 2>&1; then
  echo 'updating Homebrew Cask and packages...'
  brew cask cleanup
fi

# TODO: still not safe to do this
# https://github.com/npm/npm/issues/6247
#if type npm > /dev/null 2>&1; then
#  echo 'updating NPM and packages...'
#  npm -g update
#fi

source $(dirname $0)/../packages/nodejs-update.sh

if type npm > /dev/null 2>&1; then
  echo 'updating NPM and packages...'
  npm cache clean
  for package in $(npm -g outdated --parseable --depth=0 | cut -d: -f2)
  do
    npm -g install "$package"
  done
fi

source $(dirname $0)/../packages/ruby-update.sh

if type gem > /dev/null 2>&1; then
  echo 'updating Ruby gems...'
  gem update
  gem cleanup
fi

if type apm > /dev/null 2>&1; then
  echo 'updating Atom packages...'
  apm upgrade --confirm false
fi

if type boot2docker > /dev/null 2>&1; then
  boot2docker upgrade
fi

source $(dirname $0)/../packages/vim-update.sh
