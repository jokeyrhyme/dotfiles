#!/bin/bash

if [ -d "$HOME"/Library/Python/2.7/bin ]; then
  export PATH=$HOME/Library/Python/2.7/bin:$PATH
fi

if [ -d "$HOME"/Library/Python/3.6/bin ]; then
  export PATH=$HOME/Library/Python/3.6/bin:$PATH
fi

if [ -f "$HOME"/Library/Python/3.6/share/cloudtoken/shell_additions/bashrc_additions ]; then
  # shellcheck disable=SC1090
  . "$HOME"/Library/Python/3.6/share/cloudtoken/shell_additions/bashrc_additions
fi
