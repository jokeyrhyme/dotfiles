#!/bin/sh

set -e

source $(dirname $0)/../scripts/lib/utils.sh

if type brew > /dev/null 2>&1; then
  echo 'found brew!'
  brew install macvim
fi

if type dnf > /dev/null 2>&1; then
  echo 'found dnf!'
  sudo dnf install -y vim
fi

if type pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy --noconfirm gvim-python3
fi

__dotfiles_assert_in_path git
__dotfiles_assert_in_path ruby
__dotfiles_assert_in_path rake

__dotfiles_ensure_shallow_git_clone ~/.vim https://github.com/carlhuda/janus.git

__dotfiles_force_symlink ~/.dotfiles/gvimrc.after ~/.gvimrc.after
__dotfiles_force_symlink ~/.dotfiles/vimrc.after ~/.vimrc.after

__dotfiles_force_mkdir ~/.janus

__dotfiles_ensure_shallow_git_clone ~/.janus/solarized https://github.com/altercation/vim-colors-solarized.git

__dotfiles_ensure_shallow_git_clone ~/.janus/multiple-cursors https://github.com/terryma/vim-multiple-cursors.git

__dotfiles_ensure_shallow_git_clone ~/.janus/wakatime git://github.com/wakatime/vim-wakatime.git

source $(dirname $0)/vim-update.sh
