#!/bin/sh
set -e

docker rmi $(docker images -f "dangling=true" -q)
