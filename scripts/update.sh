#!/bin/sh

if type apt-get &> /dev/null; then
  echo 'updating packages with apt...'
  sudo apt-get update
  sudo apt-get autoremove -y
  sudo apt-get upgrade -y
fi

if type yum &> /dev/null; then
  echo 'updating packages with yum...'
  sudo yum upgrade -y
fi

if type pacman &> /dev/null; then
  echo 'updating packages with pacman...'
  sudo pacman -Syu
fi

if type brew &> /dev/null; then
  echo 'updating Homebrew and packages...'
  brew update && brew upgrade && brew linkapps && brew cleanup
fi

if type npm &> /dev/null; then
  echo 'updating NPM and packages...'
  npm -g update
fi

if type gem &> /dev/null; then
  echo 'updating Ruby gems...'
  gem update
  gem cleanup
fi

