#!/bin/sh

if type git > /dev/null 2>&1; then
  echo "configuring git..."

  git config --global user.email "jokeyrhyme@gmail.com"
  git config --global user.name "Ron Waldon"

  # https://keybase.io/jokeyrhyme
  git config --global user.signingKey "F96EC3B1"

  git config --global push.default "simple"

  if type gpg2 > /dev/null 2>&1; then
    git config --global gpg.program "gpg2"
  else
    git config --global --unset gpg.program
  fi

  git config --global color.ui "auto"
fi
