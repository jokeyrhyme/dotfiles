#!/bin/sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/is.sh
. ./scripts/lib/utils.sh
popd > /dev/null

if which git-flow > /dev/null 2>&1; then
  echo 'found git-flow! no install necessary'
  exit 0
fi

if __dotfiles_is_homebrew_found; then
  echo 'found brew!'
  brew install git-flow
  exit 0
fi

__dotfiles_assert_in_path wget

wget -q -O - https://raw.github.com/nvie/gitflow/develop/contrib/gitflow-installer.sh | sudo bash
