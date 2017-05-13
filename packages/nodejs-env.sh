#!/bin/sh

if [ -f ~/.nvs/nvs.sh ]; then
  export NVS_HOME="$HOME/.nvs"
  pushd "$NVS_HOME" > /dev/null
  # shellcheck disable=SC1091
  . ./nvs.sh
  popd > /dev/null
fi
