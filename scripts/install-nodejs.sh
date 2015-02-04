#!/bin/sh

set -e

source $(dirname $0)/lib/utils.sh

__dotfiles_assert_in_path git

__dotfiles_ensure_shallow_git_clone ~/.nvm https://github.com/creationix/nvm.git

source ~/.nvm/nvm.sh

__dotfiles_force_mkdir ~/.npm-packages

nvm install 0.10
nvm alias default 0.10
nvm use 0.10
