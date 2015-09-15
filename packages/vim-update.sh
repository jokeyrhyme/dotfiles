#!/bin/sh

set -e

. $(dirname $0)/../scripts/lib/utils.sh

__dotfiles_assert_in_path git

if [ -d ~/.vim_runtime/.git ]; then
  echo "updating amix/vimrc..."
  __dotfiles_update_shallow_git_clone ~/.vim_runtime
fi

__dotfiles_force_symlink ~/.dotfiles/my_configs.vim ~/.vim_runtime/my_configs.vim

__dotfiles_update_shallow_git_clone ~/.vim_runtime/sources_non_forked/wakatime
