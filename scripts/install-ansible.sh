#!/bin/sh

if type pip2 &> /dev/null; then
  sudo pip2 install --upgrade ansible
elif type pip &> /dev/null; then
  sudo pip install --upgrade ansible
fi


