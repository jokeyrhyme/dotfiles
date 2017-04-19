#!/bin/sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/utils.sh
popd > /dev/null

__dotfiles_assert_in_path git

__dotfiles_ensure_shallow_git_clone ~/.bash_it https://github.com/Bash-it/bash-it.git

rm -f ~/.bashrc ~/.bash_profile ~/.inputrc ~/.profile

yes | sh ~/.bash_it/install.sh

__dotfiles_force_symlink ~/.dotfiles/bashrc ~/.bashrc
__dotfiles_force_symlink ~/.dotfiles/bashrc ~/.bash_profile
__dotfiles_force_symlink ~/.dotfiles/inputrc ~/.inputrc
__dotfiles_force_symlink ~/.dotfiles/profile ~/.profile

__dotfiles_safely_set_shell /usr/bin/bash
__dotfiles_safely_set_shell /usr/local/bin/bash # homebrew

pushd "$(dirname $0)/.." > /dev/null
. ./packages/bash-update.sh
popd > /dev/null
