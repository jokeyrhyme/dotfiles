#! /usr/bin/env sh

set -e

if which apt-get > /dev/null 2>&1; then
  sudo apt-get autoremove
  sudo apt-get update
  sudo apt-get upgrade
fi

