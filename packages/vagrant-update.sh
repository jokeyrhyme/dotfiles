#!/bin/sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/utils.sh
popd > /dev/null

__dotfiles_assert_in_path git

PLUGINS=(
  "vagrant-cachier"
  "vagrant-vbguest"
)

if which vagrant > /dev/null 2>&1; then
  INSTALLED_PLUGINS=$(vagrant plugin list)
  for PLUGIN in "${PLUGINS[@]}"; do
    if ! echo "${INSTALLED_PLUGINS}" | grep "${PLUGIN} (" > /dev/null 2>&1; then
      vagrant plugin install "${PLUGIN}"
    fi
  done

  vagrant plugin update
fi
