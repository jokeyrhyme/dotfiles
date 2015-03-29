#!/bin/sh

set -e

source $(dirname $0)/../scripts/lib/utils.sh

__dotfiles_assert_in_path curl
__dotfiles_assert_in_path git

__dotfiles_update_shallow_git_clone ~/.rbenv
__dotfiles_update_shallow_git_clone ~/.rbenv/plugins/rbenv-vars
__dotfiles_update_shallow_git_clone ~/.rbenv/plugins/rbenv-gem-rehash
__dotfiles_update_shallow_git_clone ~/.rbenv/plugins/ruby-build

if [ -d ~/.rbenv/.git ]; then

  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"

  RUBY_VERSION=2.2.0
  if [ -x ~/.rbenv/versions/$RUBY_VERSION/bin/ruby ]; then
    echo "ruby $RUBY_VERSION is installed"
  else
    TMPDIR=~/.rbenv/tmp rbenv install "$RUBY_VERSION"
    rm -fr ~/.rbenv/tmp/*
  fi

  rbenv global "$RUBY_VERSION"

  # https://gist.github.com/mislav/5026283
  if [ -f $(ruby -ropenssl -e 'puts OpenSSL::X509::DEFAULT_CERT_FILE') ]; then
    echo "ruby has default certificate authorities file"
  else
    curl -fsSL curl.haxx.se/ca/cacert.pem \
      -o "$(ruby -ropenssl -e 'puts OpenSSL::X509::DEFAULT_CERT_FILE')"
  fi

fi
