#!/bin/sh

# set -e # nvm.sh triggers this

source $(dirname $0)/../scripts/lib/utils.sh

__dotfiles_assert_in_path git

__dotfiles_ensure_shallow_git_clone ~/.nvm https://github.com/creationix/nvm.git

__dotfiles_force_mkdir ~/.npm-packages

source $(dirname $0)/nodejs-update.sh

npm install -g cordova
npm install -g git-guilt
npm install -g http-server
