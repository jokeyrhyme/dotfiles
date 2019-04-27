#!/bin/sh

set -e +u

pushd "$(dirname $0)/.." >/dev/null
. ./scripts/lib/utils.sh
popd >/dev/null

set -u

__dotfiles_assert_in_path git

if which npm >/dev/null 2>&1; then
  npm config set init.author.name 'Ron Waldon'
  npm config set init.author.email 'jokeyrhyme@gmail.com'
  npm config set init.author.url 'https://github.com/jokeyrhyme'
fi

if [ -d ~/.config/yarn/global ]; then
  rm -rf "${HOME}/.config/yarn/global"
fi
