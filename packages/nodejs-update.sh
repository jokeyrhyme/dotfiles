#!/bin/bash

# set -e # nvm.sh triggers this

pushd "$(dirname $0)/.."
. ./scripts/lib/utils.sh
popd

__dotfiles_assert_in_path git

if [ -d ~/.nvm/.git ]; then
  if ! type nvm > /dev/null 2>&1; then
    pushd ~
    . ./.nvm/nvm.sh
    popd
  fi

  nvm install 4
  nvm install 6

  nvm alias default 6
  nvm use default
fi

if [ -x /usr/bin/python2 ]; then
  npm config set python /usr/bin/python2
fi

npm config set init.author.name 'Ron Waldon'
npm config set init.author.email 'jokeyrhyme@gmail.com'
npm config set init.author.url 'https://github.com/jokeyrhyme'

npm config set save-exact true

if type yarn > /dev/null 2>&1; then
  echo "updating yarn..."
  yarn self-update

  echo 'installing / updating favourite global NPM packages with yarn...'
  yarn global add npm angular-cli cordova create-react-app ember-cli git-guilt greenkeeper grunt-cli gulp http-server ionic react-native-cli typings
fi
