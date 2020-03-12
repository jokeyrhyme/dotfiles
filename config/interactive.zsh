#! /usr/bin/env zsh

if which starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if which zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh --no-define-aliases)"
fi
