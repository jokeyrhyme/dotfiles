#!/bin/sh

# set -e

source $(dirname $0)/../scripts/lib/utils.sh

__dotfiles_assert_in_path git

__dotfiles_update_shallow_git_clone ~/.oh-my-zsh

__dotfiles_ensure_shallow_git_clone ~/.zsh-pure https://github.com/sindresorhus/pure.git

mkdir -p ~/.oh-my-zsh/custom/themes
cp -v ~/.zsh-pure/pure.zsh ~/.oh-my-zsh/custom/themes/pure.zsh-theme

mkdir -p ~/.oh-my-zsh/functions
cp -v ~/.zsh-pure/async.zsh ~/.oh-my-zsh/functions/async

rm -rf ~/.zsh-pure

if [ -f ~/.oh-my-zsh/tools/upgrade.sh ]; then
  pushd ~/.oh-my-zsh
  sh ~/.oh-my-zsh/tools/upgrade.sh
  popd
fi

