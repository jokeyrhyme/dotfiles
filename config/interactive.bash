#! /usr/bin/env bash
# interactive setup for bash

# enable concurrent shell history
# https://opensource.com/article/18/5/bash-tricks
shopt -s histappend

if type starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi

