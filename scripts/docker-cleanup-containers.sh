#!/bin/sh
set -e

docker ps -a | grep 'Exited (' | awk '{print $1}' | xargs docker rm
