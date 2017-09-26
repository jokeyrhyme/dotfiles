#!/bin/sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/utils.sh
popd > /dev/null

if which gem > /dev/null 2>&1; then
  gem install rake
  gem install bundle

  echo 'updating Ruby gems...'
  gem update
  gem cleanup
fi

