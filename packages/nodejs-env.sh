#!/bin/bash

# npm
# https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md
# http://www.johnpapa.net/how-to-use-npm-global-without-sudo-on-osx/
if [ -d ~/.npm-packages ]; then
  if type npm > /dev/null 2>&1; then
    NPM_PACKAGES="${HOME}/.npm-packages"
    npm config set prefix $NPM_PACKAGES
    #export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
    export NODE_PATH="$NPM_PACKAGES/lib/node_modules"
    export PATH="$NPM_PACKAGES/bin:$PATH"
  fi
fi
