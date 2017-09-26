#!/bin/bash

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/is.sh
popd > /dev/null

# fix self-update on macOS
# https://github.com/Microsoft/vscode/issues/7426#issuecomment-277737150

if [ -d ~/Library/Caches/com.microsoft.VSCode.ShipIt ]; then
  sudo chown -R "$USER" ~/Library/Caches/com.microsoft.VSCode.ShipIt
fi
if [ -d /Applications/Visual\ Studio\ Code.app ]; then
  if which xattr > /dev/null 2>&1; then
    xattr -dr com.apple.quarantine /Applications/Visual\ Studio\ Code.app
  fi
fi

# http://www.growingwiththeweb.com/2016/06/syncing-vscode-extensions.html

EXTENSIONS=(
  "EditorConfig.EditorConfig"
  "PeterJausovec.vscode-docker"
  "dbaeumer.vscode-eslint"
  "eamodio.gitlens"
  "eg2.tslint"
  "donjayamanne.python"
  "esbenp.prettier-vscode"
  "flowtype.flow-for-vscode"
  "lukehoban.Go"
  "mitaki28.vscode-clang"
  "ms-vscode.PowerShell"
  "ms-vscode.cpptools"
  "ms-vscode.csharp"
  "msjsdiag.debugger-for-chrome"
  "rebornix.Ruby"
  "redhat.java"
  "saviorisdead.RustyCode"
  "shinnn.stylelint"
  "streetsidesoftware.code-spell-checker"
  "timonwong.shellcheck"
  "travisthetechie.write-good-linter"
  "vsmobile.cordova-tools"
  "vsmobile.vscode-react-native"
)

UNINSTALL_EXTENSIONS=(
  "georgewfraser.vscode-javac"
  "ms-vscode.latex"
  "waderyan.gitblame"
)

if __dotfiles_is_os_wsl; then
  echo "WSL detected, skipping ..."

else
  for VARIANT in "code-insiders" \
                 "code"
  do
    if hash $VARIANT 2>/dev/null; then
      INSTALLED_EXTENSIONS=$($VARIANT --list-extensions)

      echo "Installing extensions for $VARIANT..."
      for EXTENSION in "${EXTENSIONS[@]}"
      do
        if ! echo "${INSTALLED_EXTENSIONS}" | grep "${EXTENSION}" > /dev/null 2>&1; then
          $VARIANT --install-extension "$EXTENSION"
        fi
      done

      echo "Uninstalling unused extensions for $VARIANT..."
      for EXTENSION in "${UNINSTALL_EXTENSIONS[@]}"
      do
        if echo "${INSTALLED_EXTENSIONS}" | grep "${EXTENSION}" > /dev/null 2>&1; then
          $VARIANT --uninstall-extension "$EXTENSION"
        fi
      done
    fi
  done
fi


