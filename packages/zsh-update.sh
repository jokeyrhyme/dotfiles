#!/bin/sh

# set -e

source $(dirname $0)/../scripts/lib/utils.sh

__dotfiles_assert_in_path git

__dotfiles_update_shallow_git_clone ~/.oh-my-zsh

if [ -f ~/.oh-my-zsh/tools/upgrade.sh ]; then
  pushd ~/.oh-my-zsh
  sh ~/.oh-my-zsh/tools/upgrade.sh
  popd
fi

