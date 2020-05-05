#! /usr/bin/env sh

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
    if [ -f ./.venv/bin/activate ]; then
      # shellcheck disable=SC1091
      . ./.venv/bin/activate
      export PATH=./.venv/bin:$PATH
    fi
    if [ -f ./.virtualenv/bin/activate ]; then
      # shellcheck disable=SC1091
      . ./.virtualenv/bin/activate
      export PATH=./.virtualenv/bin:$PATH
    fi
  fi
}

# ensure tmux
if [ "${TMUX:-nope}" = "nope" ]; then
  if command -v tmux >/dev/null 2>&1; then
    TMUX_ARGS=new-session
    TMUX_DETACHED_SESSION=$(tmux list-sessions | grep -v attached)
    if [ -n "$TMUX_DETACHED_SESSION" ]; then
      # attach to the most recently used unattached session
      TMUX_ARGS=attach-session
    fi
    if command -v systemd-run >/dev/null 2>&1; then
      # allow detached tmux sessions to keep running after logout
      TMUX_UNIT_ID=tmux-$(tmux list-sessions | wc -l)
      systemd-run --same-dir --scope --unit $TMUX_UNIT_ID --user tmux $TMUX_ARGS
    else
      tmux $TMUX_ARGS
    fi
  fi
fi

