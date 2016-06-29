#!/bin/bash

LINUX_URL=https://go.microsoft.com/fwlink/?LinkId=723968

if [ -d /opt/VSCode-linux-x64 ]; then
    if [ $(uname -o) == "GNU/Linux" ]; then
        LINUX_DL=`mktemp`
        curl -L -o "${LINUX_DL}" "${LINUX_URL}"
        sudo rm -rf /opt/VSCode-linux-x64
        sudo tar --overwrite-dir -C /opt -Jxf "${LINUX_DL}"
        sudo chown -R root:vscode /opt/VSCode-linux-x64
        rm "${LINUX_DL}"
    fi
fi

# http://www.growingwiththeweb.com/2016/06/syncing-vscode-extensions.html

EXTENSIONS=(
    "EditorConfig.EditorConfig"
    "WakaTime.vscode-wakatime"
    "dbaeumer.vscode-eslint"
    "eg2.tslint"
    "georgewfraser.vscode-javac"
    "lukehoban.Go"
    "mitaki28.vscode-clang"
    "ms-vscode.PowerShell"
    "ms-vscode.csharp"
    "msjsdiag.debugger-for-chrome"
    "rebornix.Ruby"
    "saviorisdead.RustyCode"
    "shinnn.stylelint"
    "vsmobile.cordova-tools"
    "waderyan.gitblame"
)

for VARIANT in "code-insiders" \
               "code"
do
  if hash $VARIANT 2>/dev/null; then
    VERSION="$($VARIANT --version)"
    MAJOR="$(echo $VERSION | sed -e 's/\..*$//')"
    MINOR="$(echo $VERSION | sed -e 's/\-[a-z]*$//' -e 's/^[0-9]*\.//' -e 's/\.[0-9]*$//')"
    if [ "$MAJOR" -gt "0" ] && [ "$MINOR" -gt "1" ]; then
      echo "Installing extensions for $VARIANT"
      for EXTENSION in ${EXTENSIONS[@]}
      do
        $VARIANT --install-extension $EXTENSION
      done
    else
      echo "$VARIANT (v$VERSION) does not support extension CLI args"
    fi
  fi
done


