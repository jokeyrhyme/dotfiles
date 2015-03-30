#!/bin/sh

set -e

source $(dirname $0)/../scripts/lib/utils.sh

__dotfiles_assert_in_path git

if [ -d ~/.vim/.git ]; then
  echo "updating janus..."
  __dotfiles_update_shallow_git_clone ~/.vim
  pushd ~/.vim
  rake
  popd
fi

__dotfiles_update_shallow_git_clone ~/.janus/solarized

__dotfiles_update_shallow_git_clone ~/.janus/multiple-cursors

__dotfiles_update_shallow_git_clone ~/.janus/wakatime
