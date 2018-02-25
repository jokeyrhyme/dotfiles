#!/bin/bash

set -eu

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
