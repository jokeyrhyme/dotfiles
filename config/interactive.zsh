#! /usr/bin/env zsh

if [ -r /usr/share/fzf/completion.zsh ]; then
  . /usr/share/fzf/completion.zsh
fi
if [ -r /usr/share/fzf/key-bindings.zsh ]; then
  . /usr/share/fzf/key-bindings.zsh
fi

if type starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if type zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh --no-define-aliases)"
fi
