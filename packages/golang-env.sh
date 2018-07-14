#!/bin/sh

if [ -d ~/.local/go ]; then
  export GOROOT="$HOME/.local/go"
fi

if [ -d ~/go ]; then
  export GOPATH="$HOME/go"

  if [ -d ~/go/bin ]; then
    export PATH="$HOME/go/bin:$PATH"
  fi
fi
