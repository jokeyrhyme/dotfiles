#!/bin/sh

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/utils.sh
popd > /dev/null

if which pacaur > /dev/null 2>&1; then
  pacaur -Sy visual-studio-code
fi

# Linux
if [ -d $HOME/.config/Code ]; then
  VSCODE_CFG_DIR=$HOME/.config/Code
fi

# macOS
if [ -d "$HOME/Library/Application Support/Code" ]; then
  VSCODE_CFG_DIR="$HOME/Library/Application Support/Code"
fi

if [ -n "$VSCODE_CFG_DIR" ]; then
  mkdir -p "$VSCODE_CFG_DIR/User"
  __dotfiles_force_symlink $HOME/.dotfiles/config/vscode.json "$VSCODE_CFG_DIR/User/settings.json"
fi

pushd "$(dirname $0)/.." > /dev/null
. ./packages/vscode-update.sh
popd > /dev/null
