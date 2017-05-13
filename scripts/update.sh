#!/bin/sh

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

  if which aurget > /dev/null 2>&1; then
    echo 'updating packages with aurget...'
    aurget -Syu --noedit
  fi
fi

pushd "$(dirname $0)/.." > /dev/null
. ./packages/homebrew-update.sh
. ./packages/linuxbrew-update.sh

. ./packages/bash-update.sh
. ./packages/zsh-update.sh

. ./packages/golang-update.sh
. ./packages/nodejs-update.sh
. ./packages/ruby-update.sh

. ./packages/atom-update.sh
. ./packages/git-config.sh
. ./packages/vagrant-update.sh
. ./packages/vim-update.sh
. ./packages/vscode-update.sh
popd > /dev/null
