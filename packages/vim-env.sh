#!/bin/bash

# TODO: detect vim first
if [ ! "$EDITOR" ]; then
  export EDITOR=$(which vim)
fi
if type gvim > /dev/null 2>&1; then
  if [ -n "$DISPLAY" ]; then
    alias vim="gvim"
    alias gvim="gvim --remote-tab-silent"
  fi
fi
if type mvim > /dev/null 2>&1; then
  alias vim="mvim"
  alias mvim="mvim --remote-tab-silent"
fi
