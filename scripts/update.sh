#!/bin/sh

pushd "$(dirname $0)/.." > /dev/null
# scripts that break because of `set -e` # TODO: fixme!
. ./packages/nodejs-update.sh
popd > /dev/null

if which dnf > /dev/null 2>&1; then
  echo 'updating packages with dnf...'
  sudo dnf upgrade --obsoletes --allowerasing
elif which yum > /dev/null 2>&1; then
  echo 'updating packages with yum...'
  sudo yum upgrade -y
fi

if which pacman > /dev/null 2>&1; then
  echo 'updating packages with pacman...'
  sudo pacman -Syu
fi

if which aurget > /dev/null 2>&1; then
  echo 'updating packages with aurget...'
  aurget -Syu --noedit
fi

pushd "$(dirname $0)/.." > /dev/null
# scripts that are fine with `set -e`
. ./packages/git-config.sh
. ./packages/bash-update.sh
. ./packages/zsh-update.sh
. ./packages/homebrew-update.sh
. ./packages/golang-update.sh
. ./packages/ruby-update.sh
. ./packages/atom-update.sh
. ./packages/vagrant-update.sh
. ./packages/vim-update.sh
. ./packages/vscode-update.sh
popd > /dev/null
