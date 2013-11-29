#!/bin/sh

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

if type ansible &> /dev/null; then
  if type pip2 &> /dev/null; then
    sudo pip2 install --upgrade ansible
  elif type pip &> /dev/null; then
    sudo pip install --upgrade ansible
  fi
fi

