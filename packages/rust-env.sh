#!/usr/bin/env sh

if [ -f "${HOME}"/.cargo/env ]; then
  pushd "${HOME}" > /dev/null
  # shellcheck disable=SC1091
  . ./.cargo/env
  popd > /dev/null
fi
