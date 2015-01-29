#!/bin/sh

set -e

if type git-flow > /dev/null 2>&1; then
  echo 'found git-flow! no install necessary'
  exit 0
fi

if type brew > /dev/null 2>&1; then
  echo 'found brew!'
  brew install git-flow
  exit 0
fi

if type wget > /dev/null 2>&1; then
  echo "found wget"
else
  echo "no wget!"
  exit 1
fi

wget -q -O - https://raw.github.com/nvie/gitflow/develop/contrib/gitflow-installer.sh | sudo bash
