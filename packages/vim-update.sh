#!/bin/sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/utils.sh
popd > /dev/null

__dotfiles_assert_in_path git

if [ -d ~/.vim_runtime/.git ]; then
  echo "updating amix/vimrc..."
  __dotfiles_update_shallow_git_clone ~/.vim_runtime

  __dotfiles_remove_line ~/.vim_runtime/vimrcs/extended.vim '/set fullscreen/d'
  __dotfiles_remove_line ~/.vim_runtime/vimrcs/extended.vim '/set fuoptions/d'

  __dotfiles_force_symlink ~/.dotfiles/config/my_configs.vim ~/.vim_runtime/my_configs.vim

  __dotfiles_ensure_shallow_git_clone ~/.vim_runtime/sources_non_forked/editorconfig-vim https://github.com/editorconfig/editorconfig-vim.git

  __dotfiles_ensure_shallow_git_clone ~/.vim_runtime/sources_non_forked/vim-indent-guides https://github.com/nathanaelkane/vim-indent-guides.git

  __dotfiles_ensure_shallow_git_clone ~/.vim_runtime/sources_non_forked/vim-polyglot https://github.com/sheerun/vim-polyglot.git
fi
