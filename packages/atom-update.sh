#!/bin/bash

if which apm > /dev/null 2>&1; then
  if apm stars > /dev/null 2>&1; then
    echo 'installing favourite Atom packages...'
    apm stars --install
  fi

  echo 'updating Atom packages...'
  apm upgrade --confirm false
fi
