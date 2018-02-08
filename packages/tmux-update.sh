#!/bin/sh

set -eu

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/utils.sh
popd > /dev/null

__dotfiles_assert_in_path git

if which tmux > /dev/null 2>&1; then
  mkdir -p ~/.tmux/plugins

  __dotfiles_ensure_shallow_git_clone ~/.tmux/plugins/tpm https://github.com/tmux-plugins/tpm.git
  __dotfiles_update_shallow_git_clone ~/.tmux/plugins/tpm
fi
