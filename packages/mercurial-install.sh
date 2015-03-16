#!/bin/sh

set -e

if type brew > /dev/null 2>&1; then
  echo 'found brew! preferring brew-installed git'
  brew install mercurial
  exit 0
fi

if type hg > /dev/null 2>&1; then
  echo 'found git! no install necessary'
  exit 0
fi

if type pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy --needed --noconfirm mercurial
  exit 0
fi

if type yum > /dev/null 2>&1; then
  echo 'found yum!'
  sudo yum install -y mercurial
  exit 0
fi

if type apt > /dev/null 2>&1; then
  echo 'found apt!'
  apt-get install -y mercurial
  exit 0
fi
