#!/bin/sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/utils.sh
popd > /dev/null

__dotfiles_force_symlink ~/.dotfiles/config/hyper.js ~/.hyper.js
