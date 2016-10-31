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

if type yarn > /dev/null 2>&1; then
  echo "updating yarn..."
  yarn self-update

  echo 'installing / updating favourite global NPM packages with yarn...'
  yarn global add npm angular-cli cordova create-react-app ember-cli git-guilt greenkeeper grunt-cli gulp flow-typed http-server ionic react-native-cli typings
fi

NPM_FAVOURITES=(
  "@jokeyrhyme/node-init"
)

if type npm > /dev/null 2>&1; then
  echo 'installing favourite NPM packages...'
  for NPM_FAVOURITE in "${NPM_FAVOURITES[@]}"
  do
    if npm ls -g --depth=0 ${NPM_FAVOURITE} > /dev/null 2>&1; then
      echo "- ${NPM_FAVOURITE} is already installed"
    else
      echo "- installing ${NPM_FAVOURITE}..."
      npm install -g ${NPM_FAVOURITE}
    fi
  done

  echo 'updating NPM and packages...'
  npm cache clean
  GLOBAL_NPM_PACKAGES=''
  for package in $(npm -g outdated --parseable --depth=0 | cut -d: -f2)
  do
    GLOBAL_NPM_PACKAGES="${GLOBAL_NPM_PACKAGES} ${package}"
  done
  npm -g install ${GLOBAL_NPM_PACKAGES}
fi
