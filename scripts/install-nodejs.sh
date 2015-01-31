#!/bin/sh

set -e

source $(dirname $0)/lib/utils.sh

if type git > /dev/null 2>&1; then
  echo "found git"
else
  echo "no git!"
  exit 1
fi

__dotfiles_ensure_shallow_git_clone ~/.nvm https://github.com/creationix/nvm.git

source ~/.nvm/nvm.sh

if [ -d ~/.npm-packages ]; then
  echo "~/.npm-packages found"
else
  mkdir ~/.npm-packages
fi

nvm install 0.10
nvm alias default 0.10
nvm use 0.10
