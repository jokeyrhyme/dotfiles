#!/bin/bash

set -e

if [ -d ~/go/bin ]; then
  echo "installing latest glide.sh ..."
  curl https://glide.sh/get | sh
fi
