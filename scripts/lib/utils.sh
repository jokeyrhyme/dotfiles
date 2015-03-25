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

__dotfiles_update_shallow_git_clone() {
  if [ -d $1/.git ]; then
    echo "updating $1 ..."
    pushd $1
    git fetch --depth 1
    # git merge --no-edit --strategy recursive --strategy-option theirs FETCH_HEAD
    git reset --hard FETCH_HEAD
    popd
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

__dotfiles_force_mkdir() {
  if [ -d "$1" ]; then
    echo "$1 is a directory"
  else
    rm -f "$1"
    mkdir -p "$1"
    echo "$1 is now a directory"
  fi
}

# ln -sf fails silently, so we need this
__dotfiles_force_symlink() {
  if [ -L $2 ]; then
    echo "$2 is a symlink"
  else
    echo "$2 is not a symlink"
    rm -f $2
    ln -s $1 $2
  fi
}

__dotfiles_safely_set_shell () {
  if [ -x $1 ]; then
    if grep -q $1 /etc/shells; then
      echo "$1 already registered in /etc/shells"
    else
      echo $1 | sudo tee -a /etc/shells
      echo "$1 registered in /etc/shells"
    fi
  fi
}
