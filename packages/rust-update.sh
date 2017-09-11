#!/usr/bin/env sh

set -eu

if which rustup > /dev/null 2>&1; then
  rustup override set stable
  rustup update stable
fi
