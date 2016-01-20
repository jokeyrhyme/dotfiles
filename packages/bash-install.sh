#!/bin/sh

set -e

. $(dirname $0)/../scripts/lib/utils.sh

__dotfiles_assert_in_path git

__dotfiles_ensure_shallow_git_clone ~/.bash_it https://github.com/Bash-it/bash-it.git

rm -f ~/.bashrc ~/.bash_profile ~/.inputrc ~/.profile

yes | sh ~/.bash_it/install.sh

__dotfiles_force_symlink ~/.dotfiles/bashrc ~/.bashrc
__dotfiles_force_symlink ~/.dotfiles/bashrc ~/.bash_profile
__dotfiles_force_symlink ~/.dotfiles/inputrc ~/.inputrc
__dotfiles_force_symlink ~/.dotfiles/profile ~/.profile

#source $(dirname $0)/zsh-update.sh
# not necessary anyway, as oh-my-zsh prompts regularly to update itself

__dotfiles_safely_set_shell /usr/bin/bash
__dotfiles_safely_set_shell /usr/local/bin/bash # homebrew
