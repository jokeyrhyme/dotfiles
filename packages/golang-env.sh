#!/bin/sh

if [ -d ~/go ]; then
  export GOPATH="$HOME/go"

  if [ -d ~/go/bin ]; then
    export PATH="$HOME/go/bin:$PATH"
  fi
fi

