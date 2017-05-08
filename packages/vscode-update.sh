#!/bin/bash

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
  "eg2.tslint"
  "donjayamanne.python"
  "flowtype.flow-for-vscode"
  "lukehoban.Go"
  "mitaki28.vscode-clang"
  "ms-vscode.PowerShell"
  "ms-vscode.cpptools"
  "ms-vscode.csharp"
  "ms-vscode.latex"
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
  "waderyan.gitblame"
)

UNINSTALL_EXTENSIONS=(
  "georgewfraser.vscode-javac"
)

for VARIANT in "code-insiders" \
               "code"
do
  if hash $VARIANT 2>/dev/null; then
    echo "Installing extensions for $VARIANT"
    for EXTENSION in "${EXTENSIONS[@]}"
    do
      $VARIANT --install-extension "$EXTENSION"
    done

    echo "Uninstalling extensions for $VARIANT"
    for UNINSTALL_EXTENSIONS in "${UNINSTALL_EXTENSIONSS[@]}"
    do
      $VARIANT --install-extension "$UNINSTALL_EXTENSIONS"
    done
  fi
done
