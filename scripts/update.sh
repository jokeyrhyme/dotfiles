#!/bin/sh

if type brew > /dev/null; then
  echo 'updating Homebrew and packages...'
  brew update && brew upgrade && brew linkapps && brew cleanup
fi

if [ -f ~/.nvm/nvm.sh ]; then
  echo 'updating NVM...'
  (cd ~/.nvm && git pull)
  echo 'updating Node.JS...'
  source ~/.nvm/nvm.sh
  nvm install 0.10
  nvm alias default 0.10
  echo 'updating NPM and packages...'
  npm -g update
fi


