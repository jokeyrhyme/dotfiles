#!/bin/sh

set -e +u

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/utils.sh
. ./packages/nodejs-env.sh # `set -u` breaks nvs, so do after
popd > /dev/null

set -u

__dotfiles_assert_in_path git

__dotfiles_ensure_shallow_git_clone ~/.nvs https://github.com/jasongin/nvs.git
__dotfiles_update_shallow_git_clone ~/.nvs

if nvs --version > /dev/null 2>&1; then
  nvs add lts
  nvs add latest
  nvs link latest
fi

if which npm > /dev/null 2>&1; then
  if which python2 > /dev/null 2>&1; then
    npm config set python "$(which python2)"
  fi

  npm config set init.author.name 'Ron Waldon'
  npm config set init.author.email 'jokeyrhyme@gmail.com'
  npm config set init.author.url 'https://github.com/jokeyrhyme'

  npm config set send-metrics true
fi

if which node > /dev/null 2>&1; then
  if which node-gyp > /dev/null 2>&1; then
    node-gyp install "$(node --version)"
  fi
fi

if [ -d ~/.config/yarn/global ]; then
  rm -rf "${HOME}/.config/yarn/global"
fi
