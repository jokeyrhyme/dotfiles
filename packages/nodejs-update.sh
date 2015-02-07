#!/bin/sh

set -e

source $(dirname $0)/../scripts/lib/utils.sh

__dotfiles_assert_in_path git

__dotfiles_update_shallow_git_clone ~/.nvm

if [ -d ~/.nvm/.git ]; then
  source ~/.nvm/nvm.sh

  nvm install 0.10
  nvm install 0.12
  nvm alias default 0.12
  nvm use 0.12
fi
