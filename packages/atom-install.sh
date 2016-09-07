#!/bin/sh

if type aurget > /dev/null 2>&1; then
  echo 'found aurget!'
  aurget -Sy --noconfirm --noconfirm --builddir /var/abs/local atom-editor-bin
fi

if [ -x /usr/bin/python2 ]; then
  mkdir -p ~/.atom
  echo "python=/usr/bin/python2" >> ~/.atom/.apmrc
fi
