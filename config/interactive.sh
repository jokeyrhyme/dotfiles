#! /usr/bin/env sh
# sh/bash/zsh setup for interactive sessions

# custom `cd` command
cd() {
  if ! builtin cd "$@"; then
    return 1
  fi
  if [[ $- == *s* ]]; then
    # reading from stdin, so have a helpful `ls`
    # note that checking *i* for interactivity breaks cloudtoken
    if type exa >/dev/null 2>&1; then
      exa
    else
      ls
    fi
    if ! type nvm >/dev/null 2>&1; then
      if type nvs >/dev/null 2>&1; then
        if [ -r ./.nvmrc ]; then
          nvs use "$(cat ./.nvmrc)"
        fi
      fi
    fi
  fi
}

# ensure tmux
if [ "${TMUX:-nope}" = "nope" ]; then
  if command -v tmux > /dev/null 2>&1; then
    tmux new-session
  fi
fi
