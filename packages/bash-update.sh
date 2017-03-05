#!/bin/sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/utils.sh
popd > /dev/null

__dotfiles_assert_in_path git

__dotfiles_update_shallow_git_clone ~/.bash_it

# doesn't seem to work from here, git errors
#if [ -f ~/.oh-my-zsh/tools/upgrade.sh ]; then
#  sh ~/.oh-my-zsh/tools/upgrade.sh
#fi
# not necessary anyway, as oh-my-zsh prompts regularly to update itself
