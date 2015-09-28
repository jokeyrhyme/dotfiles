#!/bin/sh

set -e

source $(dirname $0)/../scripts/lib/utils.sh

__dotfiles_assert_in_path git

if type dnf > /dev/null 2>&1; then
  echo 'found dnf!'
  sudo dnf install -y zsh
fi

if type pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy --needed --noconfirm zsh
fi

__dotfiles_ensure_shallow_git_clone ~/.oh-my-zsh https://github.com/robbyrussell/oh-my-zsh.git

__dotfiles_force_symlink ~/.dotfiles/zshrc ~/.zshrc

#source $(dirname $0)/zsh-update.sh
# not necessary anyway, as oh-my-zsh prompts regularly to update itself

__dotfiles_safely_set_shell /usr/bin/zsh
__dotfiles_safely_set_shell /usr/local/bin/zsh # homebrew
