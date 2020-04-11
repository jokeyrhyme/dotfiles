#! /usr/bin/env sh

if type fzf >/dev/null 2>&1; then
  if type fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f'
  fi
fi
