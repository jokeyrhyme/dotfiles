#!/bin/sh

if type git > /dev/null 2>&1; then
  echo "configuring git..."

  git config --global user.name "Ron Waldon"
  git config --global user.email "jokeyrhyme@gmail.com"

  git config --global push.default simple

fi
