#!/bin/sh

if which pip2 > /dev/null 2>&1; then
  sudo pip2 install --upgrade ansible
elif which pip > /dev/null 2>&1; then
  sudo pip install --upgrade ansible
fi


