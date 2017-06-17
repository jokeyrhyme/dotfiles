#!/bin/sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/utils.sh
popd > /dev/null

__dotfiles_assert_in_path curl
__dotfiles_assert_in_path git
__dotfiles_assert_in_path ruby

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"

brew tap linuxbrew/xorg
