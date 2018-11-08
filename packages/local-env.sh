#!/bin/sh

export PATH="$HOME/.local/bin:$HOME/.local/go/bin:$HOME/.local/java/bin:$PATH"

if [ -d "$HOME/.local/node/bin" ]; then
  export PATH="$HOME/.local/node/bin:$PATH"
fi

if [ -d "$HOME/.local/nvim/bin" ]; then
  export PATH="$HOME/.local/nvim/bin:$PATH"
fi

