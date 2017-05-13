#!/bin/sh

if which pacman > /dev/null 2>&1; then
  echo 'found pacman...'

  if which python2 > /dev/null 2>&1; then
    echo 'python2 already installed'
  else
    echo 'installing python2...'
    sudo pacman -S python2
  fi

  if which pip2 > /dev/null 2>&1; then
    echo 'python2-pip already installed'
  else
    echo 'installing python2-pip...'
    sudo pacman -S python2-pip
  fi
fi


