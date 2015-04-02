#!/bin/sh

set -e

source $(dirname $0)/../scripts/lib/utils.sh

__dotfiles_assert_in_path curl
__dotfiles_assert_in_path git

if type apt-get > /dev/null 2>&1; then
  echo 'found apt-get!'
  sudo apt-get install build-essential
fi

if type dnf > /dev/null 2>&1; then
  echo 'found dnf!'
  #sudo dnf group install -y "Development Tools"
  sudo dnf install -y gcc openssl-devel libyaml-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel
fi

if type pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy --noconfirm --needed base-devel
fi

__dotfiles_ensure_shallow_git_clone ~/.rbenv https://github.com/sstephenson/rbenv.git

__dotfiles_force_mkdir ~/.rbenv/cache
__dotfiles_force_mkdir ~/.rbenv/plugins
__dotfiles_force_mkdir ~/.rbenv/tmp

__dotfiles_ensure_shallow_git_clone ~/.rbenv/plugins/rbenv-vars https://github.com/sstephenson/rbenv-vars.git

__dotfiles_ensure_shallow_git_clone ~/.rbenv/plugins/rbenv-gem-rehash https://github.com/sstephenson/rbenv-gem-rehash.git

__dotfiles_ensure_shallow_git_clone ~/.rbenv/plugins/ruby-build https://github.com/sstephenson/ruby-build.git

source $(dirname $0)/ruby-update.sh

gem install rake
gem install bundle
