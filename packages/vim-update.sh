#!/bin/sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/utils.sh
popd > /dev/null

__dotfiles_assert_in_path git

if [ -d ~/.vim_runtime/.git ]; then
  echo "updating amix/vimrc..."
  __dotfiles_update_shallow_git_clone ~/.vim_runtime
fi

__dotfiles_remove_line ~/.vim_runtime/vimrcs/extended.vim '/set fullscreen/d'
__dotfiles_remove_line ~/.vim_runtime/vimrcs/extended.vim '/set fuoptions/d'

__dotfiles_force_symlink ~/.dotfiles/my_configs.vim ~/.vim_runtime/my_configs.vim
