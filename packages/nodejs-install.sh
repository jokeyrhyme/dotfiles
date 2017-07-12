#!/bin/bash

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/is.sh
. ./scripts/lib/utils.sh
popd > /dev/null

__dotfiles_assert_in_path git

__dotfiles_ensure_shallow_git_clone ~/.nvs https://github.com/jasongin/nvs.git

if which pacaur > /dev/null 2>&1; then
  pacaur -Sy yarn
fi

if __dotfiles_is_homebrew_found; then
  brew install yarn
fi

pushd "$(dirname $0)/.." > /dev/null
. ./packages/nodejs-update.sh
popd > /dev/null
