#!/bin/sh

set -e

if type git > /dev/null 2>&1; then
  echo "found git"
else
  echo "no git!"
  exit 1
fi

if type ruby > /dev/null 2>&1; then
  echo "found ruby"
else
  echo "no ruby!"
  exit 1
fi

if type rake > /dev/null 2>&1; then
  echo "found rake"
else
  echo "no rake!"
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
  rm ~/.vimrc.after
  ln -s ~/.dotfiles/vimrc.after ~/.vimrc.after
fi

if [ -L ~/.gvimrc.after ]; then
  echo "~/.gvimrc.after is a symlink"
else
  echo "~/.gvimrc.after is not a symlink"
  rm ~/.gvimrc.after
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
