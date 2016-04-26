#!/bin/sh

# set -e # nvm.sh triggers this

. $(dirname $0)/../scripts/lib/utils.sh

__dotfiles_assert_in_path git

if [ -f ~/.nvm/install.sh ]; then
  sh ~/.nvm/install.sh
fi

if [ -d ~/.nvm/.git ]; then
  . ~/.nvm/nvm.sh

  nvm install 4
  nvm install 5
  nvm install 6

  nvm alias default 6
  nvm use default
fi

if [ -x /usr/bin/python2 ]; then
  npm config set python /usr/bin/python2
fi

npm config set save-exact true

# this isn't dangerous, but it doesn't work
# if which npm > /dev/null 2>&1; then
#   echo 'updating NPM and packages...'
#   npm -g install npm
#   npm -g update
# fi

if type npm > /dev/null 2>&1; then
  echo 'updating NPM and packages...'
  npm cache clean
  for package in $(npm -g outdated --parseable --depth=0 | cut -d: -f2)
  do
    npm -g install "$package"
  done
fi

