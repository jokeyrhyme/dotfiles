#!/usr/bin/env bash

set -eux -o pipefail

if ! [ -e /etc/fedora-release ]; then
  echo "error: this script should only be executed for Fedora"
fi

if ! which rpm-ostree > /dev/null 2>&1; then
  echo "error: this script should only be executed for Fedora Silverblue"
fi

sudo rpm-ostree install --idempotent cmake make gcc lldb tmux zsh

# https://docs.docker.com/install/linux/docker-ce/fedora/#install-docker-ce
sudo curl -L -o /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo rpm-ostree install --idempotent docker-ce
# currently fails because upstream Docker only supports Fedora 28 :S

