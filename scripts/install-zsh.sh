#!/bin/sh

set -e

source $(dirname $0)/lib/utils.sh

__dotfiles_assert_in_path git

if type brew > /dev/null 2>&1; then
  echo 'found brew!'
  brew install zsh
fi

if type pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy zsh
fi

__dotfiles_ensure_shallow_git_clone ~/.oh-my-zsh https://github.com/robbyrussell/oh-my-zsh.git

if [ -L ~/.zshrc ]; then
  echo "~/.zshrc is a symlink"
else
  echo "~/.zshrc is not a symlink"
  rm -f ~/.zshrc
  ln -s ~/.dotfiles/zshrc ~/.zshrc
fi

