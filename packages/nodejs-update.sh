#!/bin/bash

# set -e # nvm.sh triggers this

pushd "$(dirname $0)/.."
. ./scripts/lib/utils.sh
popd

__dotfiles_assert_in_path git

if [ -d ~/.nvm/.git ]; then
  if ! type nvm > /dev/null 2>&1; then
    # https://github.com/creationix/nvm#manual-upgrade
    pushd ~/.nvm
    git fetch origin
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
    . ./nvm.sh
    popd
  fi

  nvm install 4
  nvm install 6
  nvm install 7

  nvm alias default 7
  nvm use default
fi

if [ -x /usr/bin/python2 ]; then
  npm config set python /usr/bin/python2
fi

npm config set init.author.name 'Ron Waldon'
npm config set init.author.email 'jokeyrhyme@gmail.com'
npm config set init.author.url 'https://github.com/jokeyrhyme'

npm config set save-exact true

NPM_FAVOURITES=(
  "npm"
  "@jokeyrhyme/node-init"
  "angular-cli"
  "cordova"
  "create-react-app"
  "diff-so-fancy"
  "ember-cli"
  "git-guilt"
  "greenkeeper"
  "grunt-cli"
  "gulp"
  "flow-typed"
  "http-server"
  "lebab"
  "package-diff-summary"
  "ionic"
  "react-native-cli"
  "typings"
)

if type yarn > /dev/null 2>&1; then
  echo "updating yarn..."
  yarn self-update

  echo 'installing favourite global NPM packages with yarn...'
  yarn global add "${NPM_FAVOURITES[@]}"

  echo 'upgrading favourite global NPM packages with yarn...'
  yarn global upgrade
fi
