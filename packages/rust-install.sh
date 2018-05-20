#!/usr/bin/env sh

set -eu

pushd "$(dirname $0)/.." >/dev/null
. ./scripts/lib/utils.sh
popd >/dev/null

__dotfiles_assert_in_path curl

curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path -y
