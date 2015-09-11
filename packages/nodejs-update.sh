#!/bin/sh

# set -e # nvm.sh triggers this

. $(dirname $0)/../scripts/lib/utils.sh

__dotfiles_assert_in_path git

if [ -f ~/.nvm/install.sh ]; then
  sh ~/.nvm/install.sh
fi

if [ -d ~/.nvm/.git ]; then
  . ~/.nvm/nvm.sh

  nvm install 4.0

  nvm install 0.12

  nvm alias default 0.12
  nvm use default
fi

if [ -x /usr/bin/python2 ]; then
  npm config set python /usr/bin/python2
fi
