#!/bin/bash

if [ ! "$EDITOR" ]; then
  if which vim > /dev/null 2>&1; then
    EDITOR=$(which vim)
    export EDITOR
  fi
fi
if which gvim > /dev/null 2>&1; then
  if [ -n "$DISPLAY" ]; then
    alias vim="gvim"
    alias gvim="gvim --remote-tab-silent"
  fi
fi
if which mvim > /dev/null 2>&1; then
  alias vim="mvim"
  alias mvim="mvim --remote-tab-silent"
fi
