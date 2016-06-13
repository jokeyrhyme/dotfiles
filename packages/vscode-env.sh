#!/bin/bash

VSCODE_PATHS=(
  ~/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin
  ~/Applications/Visual\ Studio\ Code\ -\ Insiders.app/Contents/Resources/app/bin
  /opt/VSCode-linux-x64/bin
)
for vscode_path in "${VSCODE_PATHS[@]}"
do
  if [ -d "$vscode_path" ]; then
      export PATH=$PATH:$vscode_path
  fi
done

if type code-insiders > /dev/null 2>&1; then
  if ! type code > /dev/null 2>&1; then
    function code () { VSCODE_CWD="$PWD" code-insiders "$@" & disown; }
  fi
fi
