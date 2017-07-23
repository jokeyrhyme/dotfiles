#!/bin/sh

set -e

if which snap > /dev/null 2>&1; then
  # confirm that snap works before proceeding
  if snap interfaces > /dev/null 2>&1; then
    sudo snap refresh
  fi
fi
