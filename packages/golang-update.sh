#!/bin/sh

set -e

GO_FAVOURITES=(
  "github.com/alecthomas/gometalinter"
  "github.com/Masterminds/glide"
  "github.com/derekparker/delve/cmd/dlv"
)

if which go > /dev/null 2>&1; then
  if [ -d ~/go/bin ]; then
    for FAV in "${GO_FAVOURITES[@]}"; do
      go get -u -v $FAV
    done

    # uninstall old stuff installed by `go get -u`
    rm -rf ~/go/bin/dep ~/go/{pkg,src}/github.com/golang/dep
  fi

  if which gometalinter > /dev/null 2>&1; then
    gometalinter --install
  fi
fi
