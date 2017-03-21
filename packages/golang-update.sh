#!/bin/bash

set -e

if [ -d ~/go/bin ]; then
  echo "installing latest glide.sh ..."
  curl https://raw.githubusercontent.com/Masterminds/glide.sh/master/get | sh
fi
