#!/bin/sh

# set -e

source $(dirname $0)/../scripts/lib/utils.sh

__dotfiles_assert_in_path git

__dotfiles_update_shallow_git_clone ~/.oh-my-zsh

__dotfiles_update_shallow_git_clone ~/.zsh-pure

mkdir -p ~/.oh-my-zsh/custom/themes
cp -v ~/.zsh-pure/pure.zsh ~/.oh-my-zsh/custom/themes/pure.zsh-theme
sudo ln -s ~/.zsh-pure/async.zsh /usr/local/share/zsh/site-functions/async

if [ -f ~/.oh-my-zsh/tools/upgrade.sh ]; then
  pushd ~/.oh-my-zsh
  sh ~/.oh-my-zsh/tools/upgrade.sh
  popd
fi

