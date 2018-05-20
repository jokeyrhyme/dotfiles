#!/usr/bin/env sh

if [ -f "${HOME}"/.cargo/env ]; then
  pushd "${HOME}" >/dev/null || exit 1
  # shellcheck disable=SC1091
  . ./.cargo/env
  popd >/dev/null || exit 1
fi
