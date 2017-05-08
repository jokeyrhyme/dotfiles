#!/bin/sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/utils.sh
. ./packages/nodejs-env.sh
popd > /dev/null

__dotfiles_assert_in_path git

__dotfiles_ensure_shallow_git_clone ~/.nvs https://github.com/jasongin/nvs.git

if type nvs > /dev/null 2>&1; then
  nvs add 4
  nvs add 6
  nvs add lts
  nvs add latest
  nvs link latest
fi

if [ -x /usr/bin/python2 ]; then
  npm config set python /usr/bin/python2
fi

npm config set cache-min 3600

npm config set init.author.name 'Ron Waldon'
npm config set init.author.email 'jokeyrhyme@gmail.com'
npm config set init.author.url 'https://github.com/jokeyrhyme'

npm config set save-exact true

npm config set send-metrics true

NPM_FAVOURITES=(
  "npm"
  "@jokeyrhyme/node-init"
  "@angular/cli"
  "cordova"
  "create-react-app"
  "create-react-native-app"
  "diff-so-fancy"
  "ember-cli"
  "eslint"
  "git-guilt"
  "grunt-cli"
  "gulp"
  "flow-bin"
  "flow-typed"
  "http-server"
  "ionic"
  "lebab"
  "lerna"
  "package-diff-summary"
  "prettier"
  "react-native-cli"
  "typings"
  "unleash"
)

UNINSTALL_NPM_FAVOURITES=(
  "greenkeeper"
)

if type npm > /dev/null 2>&1; then
  echo 'updating NPM and packages...'
  npm update --global

  echo 'installing favourite NPM packages...'
  INSTALLED_FAVOURITES=$(npm ls --global --depth=0)
  for FAV in "${NPM_FAVOURITES[@]}"; do
    if ! echo "${INSTALLED_FAVOURITES}" | grep " ${FAV}@" > /dev/null 2>&1; then
      npm install --global $FAV
    fi
  done

  echo 'uninstalling unused NPM packages...'
  for FAV in "${UNINSTALL_NPM_FAVOURITES[@]}"; do
    if npm ls --global --depth=0 $FAV > /dev/null 2>&1; then
      npm uninstall --global $FAV
    fi
  done
fi

if [ -d ~/.config/yarn/global ]; then
  rm -rf "${HOME}/.config/yarn/global"
fi
