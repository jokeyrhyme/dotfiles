#!/bin/bash

# https://code.visualstudio.com/docs/editor/setup
if type open > /dev/null 2>&1; then
  if [ -d ~/Applications/Visual\ Studio\ Code.app ]; then
    function code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args "$@"; }
  fi
fi
