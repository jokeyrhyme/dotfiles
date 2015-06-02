#!/bin/sh

set -e

if type brew > /dev/null 2>&1; then
  echo 'found brew! preferring brew-installed git'
  brew install git
fi

if type pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy --needed --noconfirm git
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

source $(dirname $0)/git-config.sh
