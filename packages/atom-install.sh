#!/bin/sh

if type pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -S atom apm
fi

if [ -x /usr/bin/python2 ]; then
  mkdir -p ~/.atom
  echo "python=/usr/bin/python2" >> ~/.atom/.apmrc
fi
