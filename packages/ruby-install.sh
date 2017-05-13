#!/bin/sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/utils.sh
popd > /dev/null

__dotfiles_assert_in_path curl
__dotfiles_assert_in_path git

if which apt-get > /dev/null 2>&1; then
  echo 'found apt-get!'
  sudo apt-get install build-essential
fi

if which dnf > /dev/null 2>&1; then
  echo 'found dnf!'
  #sudo dnf group install -y "Development Tools"
  sudo dnf install -y gcc openssl-devel libyaml-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel
fi

if which pacman > /dev/null 2>&1; then
  echo 'found pacman!'

  # base-devel includes gcc which conflicts with multilib :S
  if ! pacman -Q gcc-multilib > /dev/null 2>&1; then
    sudo pacman -Sy --noconfirm --needed base-devel
  fi
fi

__dotfiles_ensure_shallow_git_clone ~/.rbenv https://github.com/sstephenson/rbenv.git

__dotfiles_force_mkdir ~/.rbenv/cache
__dotfiles_force_mkdir ~/.rbenv/plugins
__dotfiles_force_mkdir ~/.rbenv/tmp

__dotfiles_ensure_shallow_git_clone ~/.rbenv/plugins/rbenv-vars https://github.com/sstephenson/rbenv-vars.git

__dotfiles_ensure_shallow_git_clone ~/.rbenv/plugins/rbenv-gem-rehash https://github.com/sstephenson/rbenv-gem-rehash.git

__dotfiles_ensure_shallow_git_clone ~/.rbenv/plugins/ruby-build https://github.com/sstephenson/ruby-build.git

gem install rake
gem install bundle

pushd "$(dirname $0)/.." > /dev/null
. ./packages/ruby-update.sh
popd > /dev/null
