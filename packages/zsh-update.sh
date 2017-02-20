#!/bin/sh

# set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/utils.sh
popd > /dev/null

__dotfiles_assert_in_path git

## just let oh-my-zsh use its own updater for now

__dotfiles_ensure_shallow_git_clone ~/.zsh-pure https://github.com/sindresorhus/pure.git

mkdir -p ~/.oh-my-zsh/custom/themes
cp -v ~/.zsh-pure/pure.zsh ~/.oh-my-zsh/custom/themes/pure.zsh-theme

mkdir -p ~/.oh-my-zsh/functions
cp -v ~/.zsh-pure/async.zsh ~/.oh-my-zsh/functions/async

rm -rf ~/.zsh-pure
