#!/bin/sh

__dotfiles_ensure_shallow_git_clone() {
  if [ -d $1/.git ]; then
    echo "$1 is a git repo"
  else
    echo "$1 is not a git repo"
    rm -fr $1
    git clone --depth 1 $2 $1
  fi
}

__dotfiles_assert_in_path() {
  if type $1 > /dev/null 2>&1; then
    echo "found $1"
  else
    echo "error: no $1!"
    exit 1
  fi
}
