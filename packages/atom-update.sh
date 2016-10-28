#!/bin/bash

if which apm > /dev/null 2>&1; then
  echo 'updating Atom packages...'
  apm upgrade --confirm false
fi
