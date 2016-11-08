#!/bin/sh

if which pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy atom apm
fi

if [ -x /usr/bin/python2 ]; then
  mkdir -p ~/.atom
  echo "python=/usr/bin/python2" >> ~/.atom/.apmrc
fi
