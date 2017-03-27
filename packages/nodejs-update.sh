#!/bin/bash

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

npm config set init.author.name 'Ron Waldon'
npm config set init.author.email 'jokeyrhyme@gmail.com'
npm config set init.author.url 'https://github.com/jokeyrhyme'

npm config set save-exact true

# echo "installing / updating yarn..."
# YARN_URL="https://yarnpkg.com/latest.tar.gz"
# mkdir -p ~/.yarn
# __dotfiles_download_extract_tgz "${YARN_URL}" ~/.yarn

NPM_FAVOURITES=(
  "npm"
  "@jokeyrhyme/node-init"
  "@angular/cli"
  "cordova"
  "create-react-app"
  "create-react-native-app"
  "diff-so-fancy"
  "ember-cli"
  "git-guilt"
  "greenkeeper"
  "grunt-cli"
  "gulp"
  "flow-bin"
  "flow-typed"
  "http-server"
  "lebab"
  "lerna"
  "package-diff-summary"
  "ionic"
  "react-native-cli"
  "typings"
  "unleash"
)

if type yarn > /dev/null 2>&1; then
  echo 'installing favourite global NPM packages with yarn...'
  yarn global add "${NPM_FAVOURITES[@]}"

  echo 'upgrading favourite global NPM packages with yarn...'
  yarn global upgrade
fi
