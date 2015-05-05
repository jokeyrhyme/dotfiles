#!/bin/sh

set -e

if type brew > /dev/null 2>&1; then
  echo 'found brew! preferring brew-installed git'
  brew install git
  exit 0
fi

if type pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy --needed --noconfirm git
  exit 0
fi

if type dnf > /dev/null 2>&1; then
  echo 'found dnf!'
  sudo dnf install -y git gitflow
  exit 0
fi

if type yum > /dev/null 2>&1; then
  echo 'found yum!'
  sudo yum install -y git
  exit 0
fi

if type apt > /dev/null 2>&1; then
  echo 'found apt!'
  apt-get install -y git
  exit 0
fi
