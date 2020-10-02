#! /usr/bin/env bash

# enable concurrent shell history
# https://opensource.com/article/18/5/bash-tricks
shopt -s histappend

if [ -r /usr/share/fzf/completion.bash ]; then
  . /usr/share/fzf/completion.bash
fi
if [ -r /usr/share/fzf/key-bindings.bash ]; then
  . /usr/share/fzf/key-bindings.bash
fi

if type starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi

if type zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash --no-define-aliases)"
fi
