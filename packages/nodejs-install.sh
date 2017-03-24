#!/bin/bash

# set -e # nvm.sh triggers this

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/utils.sh
popd > /dev/null

__dotfiles_assert_in_path git

__dotfiles_ensure_shallow_git_clone ~/.nvm https://github.com/creationix/nvm.git

if which brew > /dev/null 2>&1; then
  brew install yarn
fi

pushd "$(dirname $0)" > /dev/null
. ./nodejs-update.sh
popd > /dev/null
