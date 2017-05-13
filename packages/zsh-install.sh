#!/bin/sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/utils.sh
popd > /dev/null

__dotfiles_assert_in_path git

if which dnf > /dev/null 2>&1; then
  echo 'found dnf!'
  sudo dnf install -y zsh
fi

if which pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy --needed --noconfirm zsh
fi

__dotfiles_ensure_shallow_git_clone ~/.oh-my-zsh https://github.com/robbyrussell/oh-my-zsh.git

__dotfiles_force_symlink ~/.dotfiles/zshrc ~/.zshrc
__dotfiles_force_symlink ~/.dotfiles/profile ~/.profile

#source $(dirname $0)/zsh-update.sh
# not necessary anyway, as oh-my-zsh prompts regularly to update itself

__dotfiles_safely_set_shell /usr/bin/zsh
__dotfiles_safely_set_shell /usr/local/bin/zsh # homebrew

pushd "$(dirname $0)/.." > /dev/null
. ./packages/zsh-update.sh
popd > /dev/null
