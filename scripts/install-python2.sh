#!/bin/sh

if type pacman &> /dev/null; then
  echo 'found pacman...'

  if type python2 &> /dev/null; then
    echo 'python2 already installed'
  else
    echo 'installing python2...'
    sudo pacman -S python2
  fi

  if type pip2 &> /dev/null; then
    echo 'python2-pip already installed'
  else
    echo 'installing python2-pip...'
    sudo pacman -S python2-pip
  fi
fi


