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

NPM_FAVOURITES=(
  "cordova"
  "create-react-app"
  "git-guilt"
  "grunt-cli"
  "gulp"
  "http-server"
  "ionic"
)

if type npm > /dev/null 2>&1; then
  echo 'installing favourite NPM packages...'
  for NPM_FAVOURITE in ${NPM_FAVOURITES[@]}
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
  for package in $(npm -g outdated --parseable --depth=0 | cut -d: -f2)
  do
    npm -g install "$package"
  done
fi

