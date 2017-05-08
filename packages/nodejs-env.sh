#!/bin/sh

if [ -f ~/.nvs/nvs.sh ]; then
  export NVS_HOME="$HOME/.nvs"
  pushd "$NVS_HOME" > /dev/null
  . ./nvs.sh
  popd > /dev/null
fi
