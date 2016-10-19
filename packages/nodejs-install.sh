#!/bin/bash

# set -e # nvm.sh triggers this

pushd "$(dirname $0)/.."
. ./scripts/lib/utils.sh
popd

__dotfiles_assert_in_path git

__dotfiles_ensure_shallow_git_clone ~/.nvm https://github.com/creationix/nvm.git

pushd "$(dirname $0)"
. ./nodejs-update.sh
popd

echo "installing yarn..."
YARN_URL="https://yarnpkg.com/latest.tar.gz"
mkdir -p ~/.yarn
__dotfiles_download_extract_tgz "${YARN_URL}" ~/.yarn
