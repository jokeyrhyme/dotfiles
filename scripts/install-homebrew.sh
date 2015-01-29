#!/bin/sh

set -e

if type ruby > /dev/null 2>&1; then
  echo "found ruby"
else
  echo "no ruby!"
  exit 1
fi

if type git > /dev/null 2>&1; then
  echo "found git"
else
  echo "no git!"
  exit 1
fi

if type xcode-select > /dev/null 2>&1; then
  echo "found xcode-select"
else
  echo "no xcode-select! is this OS X?"
  exit 1
fi

if type brew > /dev/null 2>&1; then
  echo 'found brew! no install necessary'
  exit 0
fi

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
