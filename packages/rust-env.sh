#!/usr/bin/env sh

if [ -f "${HOME}"/.cargo/env ]; then
  pushd "${HOME}" > /dev/null
  . ./.cargo/env
  popd > /dev/null
fi
