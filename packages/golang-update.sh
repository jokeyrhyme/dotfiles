#!/bin/sh

set -e

if which go > /dev/null 2>&1; then
  if [ -d ~/go/bin ]; then
    echo "installing latest glide.sh ..."
    go get -u github.com/Masterminds/glide
  fi
fi
