#!/bin/sh

if type go > /dev/null 2>&1; then
  GO=$(which go)
  if [ -n "$GO" ]; then
    export GOROOT=$(dirname $(dirname $GO))
    if [ -h "$GO" ]; then
      PLATFORM=$(uname -s)
      if [ "$PLATFORM" = 'Linux' ]; then
        GO_SYM=$(readlink -f $GO)
      fi
      if [ "$PLATFORM" = 'Darwin' ]; then
        GO_SYM=$(readlink $GO)
      fi
      if [ -n "$GO_SYM" ]; then
        if [[ $GO_SYM == ..* ]]; then
          GO_SYM=$(dirname $GO)/$GO_SYM
        fi
        export GOROOT=$(dirname $(dirname $GO_SYM))
      fi
    fi
    mkdir -p "$HOME"/Projects/GOPATH/bin
    if type brew > /dev/null 2>&1; then
      export GOROOT=$(brew --prefix)/opt/go/libexec
    fi
    if [ -x /usr/lib/go/bin/go ]; then
      export GOROOT=/usr/lib/go
    fi
    export GOPATH=$HOME/Projects/GOPATH
    export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
  fi
fi
