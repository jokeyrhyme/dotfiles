#!/bin/sh

if which aurget > /dev/null 2>&1; then
  echo 'found pacman!'
  aurget -Sy visual-studio-code
fi
