#!/bin/sh

if which yarn > /dev/null 2>&1; then
  export PATH="$PATH:$(yarn global bin)"
fi

if [ -d ~/.config/yarn/global/node_modules/.bin ]; then
  export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi
