#!/bin/sh

set -e

pushd "$(dirname $0)/.." >/dev/null
. ./scripts/lib/utils.sh
popd >/dev/null

__dotfiles_assert_in_path curl
__dotfiles_assert_in_path git
__dotfiles_assert_in_path ruby

if which apt-get >/dev/null 2>&1; then
  sudo apt-get install -y build-essential
fi

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"

brew tap linuxbrew/xorg
