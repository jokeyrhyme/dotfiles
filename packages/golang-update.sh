#!/bin/sh

set -e

GO_FAVOURITES=(
  "github.com/alecthomas/gometalinter"
  "github.com/Masterminds/glide"
  "github.com/derekparker/delve/cmd/dlv"
  "github.com/golang/dep/cmd/dep"
)

if which go > /dev/null 2>&1; then
  if [ -d ~/go/bin ]; then
    for FAV in "${GO_FAVOURITES[@]}"; do
      go get -u -v $FAV
    done
  fi

  if which gometalinter > /dev/null 2>&1; then
    gometalinter --install
  fi
fi
