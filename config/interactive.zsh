#! /usr/bin/env zsh
# interactive setup for zsh

if which starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

