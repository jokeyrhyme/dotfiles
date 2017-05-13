#!/bin/sh

set -e

# shellcheck disable=SC2046
docker rmi $(docker images -f "dangling=true" -q)
