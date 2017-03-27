#!/bin/sh

if [ -f ~/.nvs/nvs.sh ]; then
  export NVS_HOME="$HOME/.nvs"
  pushd "$NVS_HOME" > /dev/null
  . ./nvs.sh
  popd > /dev/null
fi

if which yarn > /dev/null 2>&1; then
  export PATH="$PATH:$(yarn global bin)"
fi

if [ -d ~/.config/yarn/global/node_modules/.bin ]; then
  export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi
