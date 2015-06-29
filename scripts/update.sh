#!/bin/sh

source $(dirname $0)/../packages/git-config.sh

if type dnf > /dev/null 2>&1; then
  echo 'updating packages with dnf...'
  sudo dnf upgrade --obsoletes --allowerasing
elif type yum > /dev/null 2>&1; then
  echo 'updating packages with yum...'
  sudo yum upgrade -y
fi

if type pacman > /dev/null 2>&1; then
  echo 'updating packages with pacman...'
  sudo pacman -Syu
fi

if type aurget > /dev/null 2>&1; then
  echo 'updating packages with aurget...'
  aurget -Syu --noedit
fi

if type brew > /dev/null 2>&1; then
  echo 'updating Homebrew and packages...'
  brew update && brew upgrade --all && brew linkapps && brew cleanup
fi

if type brew-cask.rb > /dev/null 2>&1; then
  echo 'updating Homebrew Cask and packages...'
  brew cask cleanup
fi

source $(dirname $0)/../packages/nodejs-update.sh

if type npm > /dev/null 2>&1; then
  echo 'updating NPM and packages...'
  npm -g install npm
  npm -g update
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

if type docker-machine > /dev/null 2>&1; then
  if docker-machine ip > /dev/null 2>&1; then
    docker-machine upgrade
  fi
fi

source $(dirname $0)/../packages/vim-update.sh
