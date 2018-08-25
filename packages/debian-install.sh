#!/usr/bin/env bash

set -eux -o pipefail

if ! lsb_release -i | grep 'Debian' > /dev/null; then
  echo "error: this script should only be executed for Debian Linux"
  exit 1
fi

sudo apt-get update
sudo apt-get install --yes build-essential cmake fuse man libgit2-dev python python3 zsh
sudo apt-get autoclean

# stretch-backports certificate cannot be verified without this
sudo apt-get install --fix-broken --reinstall --yes ca-certificates

# stretch-backports has a newer tmux version
sudo sh -c 'echo "deb http://ftp.debian.org/debian stretch-backports main" > /etc/apt/sources.list.d/stretch-backports.list'
sudo apt-get update

sudo apt-get -t stretch-backports install --yes tmux

# docker
sudo apt-get remove --yes docker docker-engine docker.io
sudo apt-get install --yes apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
if ! sudo apt-key fingerprint 0EBFCD88 | grep 'E2D8 8D81 803C 0EBF CD88' > /dev/null; then
  echo "error: docker.com fingerprint not found in apt keyring"
  exit 1
fi
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install --yes docker-ce

