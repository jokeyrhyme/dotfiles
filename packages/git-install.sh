#!/bin/sh

set -e

if type brew > /dev/null 2>&1; then
  echo 'found brew! preferring brew-installed git'

  sudo chmod g+w /usr/local/share/zsh /usr/local/share/zsh/site-functions

  brew install git git-lfs git-flow

  sudo chmod g-w /usr/local/share/zsh /usr/local/share/zsh/site-functions
fi

if type pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy --needed --noconfirm git

  if which aurget > /dev/null 2>&1; then
    echo 'found aurget!'
    aurget -Sy git-crypt git-lfs
  fi
fi

if type dnf > /dev/null 2>&1; then
  echo 'found dnf!'
  sudo dnf install -y git gitflow

elif type yum > /dev/null 2>&1; then
  echo 'found yum!'
  sudo yum install -y git
fi

if type apt-get > /dev/null 2>&1; then
  echo 'found apt!'
  apt-get install -y git
fi

pushd "$(dirname $0)" > /dev/null
. ./git-config.sh
popd > /dev/null
