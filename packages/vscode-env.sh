#!/bin/bash

VSCODE_PATHS=(
  ~/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin
  ~/Applications/Visual\ Studio\ Code\ -\ Insiders.app/Contents/Resources/app/bin
  /opt/VSCode-linux-x64
)
for vscode_path in "${VSCODE_PATHS[@]}"
do
  if [ -d "$vscode_path" ]; then
      export PATH=$PATH:$vscode_path
  fi
done

