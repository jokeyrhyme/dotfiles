#!/bin/sh

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/utils.sh
popd > /dev/null

if which pacaur > /dev/null 2>&1; then
  pacaur -Sy --needed --noconfirm visual-studio-code
fi

# https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions
if which rpm > /dev/null 2>&1; then
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
  
  if which dnf > /dev/null 2>&1; then
    dnf check-update
    sudo dnf install code
  fi
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
