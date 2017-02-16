#!/bin/bash

# http://www.growingwiththeweb.com/2016/06/syncing-vscode-extensions.html

EXTENSIONS=(
  "EditorConfig.EditorConfig"
  "WakaTime.vscode-wakatime"
  "dbaeumer.vscode-eslint"
  "eg2.tslint"
  "flowtype.flow-for-vscode"
  "georgewfraser.vscode-javac"
  "lukehoban.Go"
  "mitaki28.vscode-clang"
  "ms-vscode.PowerShell"
  "ms-vscode.csharp"
  "msjsdiag.debugger-for-chrome"
  "rebornix.Ruby"
  "saviorisdead.RustyCode"
  "shinnn.stylelint"
  "streetsidesoftware.code-spell-checker"
  "timonwong.shellcheck"
  "travisthetechie.write-good-linter"
  "vsmobile.cordova-tools"
  "vsmobile.vscode-react-native"
  "waderyan.gitblame"
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
  fi
done
