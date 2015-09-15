#!/bin/sh

set -e

. $(dirname $0)/../scripts/lib/utils.sh

if which brew > /dev/null 2>&1; then
  echo 'found brew!'
  brew install ctags macvim
fi

if which dnf > /dev/null 2>&1; then
  echo 'found dnf!'
  sudo dnf install -y ctags vim
  if which Xorg > /dev/null 2>&1; then
    echo 'found Xorg!'
    sudo dnf install -y vim-X11
  fi
fi

if which pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy --noconfirm ctags gvim-python3
fi

__dotfiles_assert_in_path git

__dotfiles_ensure_shallow_git_clone ~/.vim_runtime https://github.com/amix/vimrc.git
sh ~/.vim_runtime/install_awesome_vimrc.sh

__dotfiles_ensure_shallow_git_clone ~/.vim_runtime/sources_non_forked/wakatime git://github.com/wakatime/vim-wakatime.git

. $(dirname $0)/vim-update.sh
