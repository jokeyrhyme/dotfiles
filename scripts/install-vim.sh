#!/bin/sh

set -e

source $(dirname $0)/lib/utils.sh

if type brew > /dev/null 2>&1; then
  echo 'found brew!'
  brew install macvim
fi

if type pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy gvim-python3
fi

__dotfiles_assert_in_path git

__dotfiles_assert_in_path ruby

__dotfiles_assert_in_path rake

__dotfiles_ensure_shallow_git_clone ~/.vim https://github.com/carlhuda/janus.git

if [ -L ~/.vimrc ]; then
  echo "~/.vimrc is a symlink"
else
  echo "~/.vimrc is not a symlink"
  pushd ~/.vim
  rake
  popd
fi

if [ -L ~/.vimrc.after ]; then
  echo "~/.vimrc.after is a symlink"
else
  echo "~/.vimrc.after is not a symlink"
  rm -f ~/.vimrc.after
  ln -s ~/.dotfiles/vimrc.after ~/.vimrc.after
fi

if [ -L ~/.gvimrc.after ]; then
  echo "~/.gvimrc.after is a symlink"
else
  echo "~/.gvimrc.after is not a symlink"
  rm -f ~/.gvimrc.after
  ln -s ~/.dotfiles/gvimrc.after ~/.gvimrc.after
fi

if [ -d ~/.janus/ ]; then
  echo "~/.janus is a directory"
else
  echo "~/.janus is not a directory"
  mkdir -p ~/.janus
fi

__dotfiles_ensure_shallow_git_clone ~/.janus/emmet https://github.com/mattn/emmet-vim.git

__dotfiles_ensure_shallow_git_clone ~/.janus/solarized https://github.com/altercation/vim-colors-solarized.git

__dotfiles_ensure_shallow_git_clone ~/.janus/multiple-cursors https://github.com/terryma/vim-multiple-cursors.git

__dotfiles_ensure_shallow_git_clone ~/.janus/wakatime git://github.com/wakatime/vim-wakatime.git
