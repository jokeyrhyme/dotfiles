#!/bin/sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/utils.sh
popd > /dev/null

__dotfiles_assert_in_path git

__dotfiles_ensure_shallow_git_clone ~/.nvs https://github.com/jasongin/nvs.git

PLUGINS=(
  "vagrant-cachier"
  "vagrant-vbguest"
)

if type vagrant > /dev/null 2>&1; then
  INSTALLED_PLUGINS=$(vagrant plugin list)
  for PLUGIN in "${PLUGINS[@]}"; do
    if ! echo "${INSTALLED_PLUGINS}" | grep "${PLUGIN} (" > /dev/null 2>&1; then
      vagrant plugin install "${PLUGIN}"
    fi
  done

  vagrant plugin update
fi
