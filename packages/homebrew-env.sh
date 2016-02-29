#!/bin/bash

# OS X
if [ "${TERM_PROGRAM}" = "Apple_Terminal" ]; then
  if [ -x /usr/local/bin/brew ]; then
    export PATH=/usr/local/sbin:$PATH
  fi
fi
