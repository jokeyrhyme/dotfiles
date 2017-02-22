#!/bin/bash

# add "/bin" to GEMPATHs and add to PATH
if which gem > /dev/null 2>&1; then
  if gem environment gempath > /dev/null 2>&1; then
    if [ -n "$(gem environment gempath)" ]; then
      PATH="$(gem environment gempath | sed -e 's/:/\/bin:/g')/bin:$PATH"
      export PATH
    fi
  fi
fi

# rbenv
if [ -x ~/.rbenv/bin/rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

