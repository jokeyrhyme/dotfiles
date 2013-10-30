#!/bin/sh

if type brew > /dev/null; then
  echo 'updating Homebrew and packages...'
  brew update && brew upgrade && brew linkapps && brew cleanup
fi

if type npm > /dev/null; then
  echo 'updating NPM and packages...'
  npm -g update
fi

if type gem > /dev/null; then
  echo 'updating Ruby gems...'
  gem update
  gem cleanup
fi


