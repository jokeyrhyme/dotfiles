#!/bin/sh

set -e

source $(dirname $0)/../scripts/lib/utils.sh

__dotfiles_force_symlink ~/.dotfiles/config/hyper.js ~/.hyper.js
