#!/bin/sh

set -e

source $(dirname $0)/../scripts/lib/utils.sh

__dotfiles_assert_in_path git

__dotfiles_update_shallow_git_clone ~/.oh-my-zsh

# doesn't seem to work from here, git errors
#if [ -f ~/.oh-my-zsh/tools/upgrade.sh ]; then
#  sh ~/.oh-my-zsh/tools/upgrade.sh
#fi
# not necessary anyway, as oh-my-zsh prompts regularly to update itself
