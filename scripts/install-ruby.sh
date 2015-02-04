#!/bin/sh

set -e

source $(dirname $0)/lib/utils.sh

__dotfiles_assert_in_path curl

__dotfiles_assert_in_path git

if type apt-get > /dev/null 2>&1; then
  echo 'found apt-get!'
  sudo apt-get install build-essential
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

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

RUBY_VERSION=2.2.0
if [ -x ~/.rbenv/versions/$RUBY_VERSION/bin/ruby ]; then
  echo "ruby $RUBY_VERSION is installed"
else
  TMPDIR=~/.rbenv/tmp rbenv install 2.2.0
  rm -fr ~/.rbenv/tmp/*
fi

rbenv global 2.2.0

# https://gist.github.com/mislav/5026283
if [ -f $(ruby -ropenssl -e 'puts OpenSSL::X509::DEFAULT_CERT_FILE') ]; then
  echo "ruby has default certificate authorities file"
else
  curl -fsSL curl.haxx.se/ca/cacert.pem \
    -o "$(ruby -ropenssl -e 'puts OpenSSL::X509::DEFAULT_CERT_FILE')"
fi


