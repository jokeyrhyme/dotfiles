#!/bin/sh

. $(dirname $0)/../packages/git-config.sh

. $(dirname $0)/../packages/bash-update.sh

. $(dirname $0)/../packages/zsh-update.sh

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

. $(dirname $0)/../packages/homebrew-update.sh

. $(dirname $0)/../packages/nodejs-update.sh

. $(dirname $0)/../packages/ruby-update.sh

if which apm > /dev/null 2>&1; then
  echo 'updating Atom packages...'
  apm upgrade --confirm false
fi

. $(dirname $0)/../packages/vim-update.sh

. $(dirname $0)/../packages/vscode-update.sh
