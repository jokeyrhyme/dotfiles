#!/bin/bash

# http://www.growingwiththeweb.com/2016/06/syncing-vscode-extensions.html

EXTENSIONS=(
)

for VARIANT in "code" \
               "code-insiders"
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
