#!/bin/sh

set -e

if which snap > /dev/null 2>&1; then
  sudo snap refresh
fi
