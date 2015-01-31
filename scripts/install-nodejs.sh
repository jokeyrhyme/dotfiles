#!/bin/sh

set -e

if type git > /dev/null 2>&1; then
  echo "found git"
else
  echo "no git!"
  exit 1
fi

__dotfiles_ensure_shallow_git_clone() {
  if [ -d $1/.git ]; then
    echo "$1 is a git repo"
  else
    echo "$1 is not a git repo"
    rm -fr $1
    git clone --depth 1 $2 $1
  fi
}

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
