#!/bin/sh

set -e

if type git > /dev/null 2>&1; then
  echo "found git"
else
  echo "no git!"
  exit 1
fi

if type brew > /dev/null 2>&1; then
  echo 'found brew!'
  brew install zsh
fi

if type pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy zsh
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

__dotfiles_ensure_shallow_git_clone ~/.oh-my-zsh https://github.com/robbyrussell/oh-my-zsh.git

if [ -L ~/.zshrc ]; then
  echo "~/.zshrc is a symlink"
else
  echo "~/.zshrc is not a symlink"
  rm -f ~/.zshrc
  ln -s ~/.dotfiles/zshrc ~/.zshrc
fi

