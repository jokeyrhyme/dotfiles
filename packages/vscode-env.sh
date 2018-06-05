#!/bin/bash

VSCODE_PATHS=(
  ~/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin
  ~/.local/VSCode-linux-x64/bin
)
for vscode_path in "${VSCODE_PATHS[@]}"; do
  if [ -d "$vscode_path" ]; then
    export PATH=$PATH:$vscode_path
  fi
done
