#!/bin/sh

if [ -d ~/.yarn/bin ]; then
  export PATH="$HOME/.yarn/bin:$PATH"
fi

if [ -d ~/.config/yarn/global/node_modules/.bin ]; then
  export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi
