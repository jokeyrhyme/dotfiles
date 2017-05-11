#!/bin/sh

__dotfiles_ensure_shallow_git_clone() { # dirPath, gitUrl
  if [ -d $1/.git ]; then
    echo "$1 is a git repo"
  else
    echo "$1 is not a git repo"
    rm -fr $1
    git clone --depth 1 $2 $1
  fi
}

__dotfiles_update_shallow_git_clone() { # dirPath
  if [ -d $1/.git ]; then
    echo "updating $1 ..."
    pushd $1
    git fetch --depth 1
    # git merge --no-edit --strategy recursive --strategy-option theirs FETCH_HEAD
    git reset --hard FETCH_HEAD
    popd > /dev/null
  fi
}

__dotfiles_assert_in_path() { # binBasename
  if type $1 > /dev/null 2>&1; then
    echo "found $1"
  else
    echo "error: no $1!"
    exit 1
  fi
}

__dotfiles_force_mkdir() { # dirPath
  if [ -d "$1" ]; then
    echo "$1 is a directory"
  else
    rm -f "$1"
    mkdir -p "$1"
    echo "$1 is now a directory"
  fi
}

# ln -sf fails silently, so we need this
__dotfiles_force_symlink() { # sourcePath, # targetPath
  if [ -L "$2" ]; then
    echo "$2 is a symlink"
  else
    echo "$2 is not a symlink"
    rm -f "$2"
    ln -s "$1" "$2"
  fi
}

__dotfiles_safely_set_shell() { # shellPath
  if [ -x $1 ]; then
    if grep -q $1 /etc/shells; then
      echo "$1 already registered in /etc/shells"
    else
      echo $1 | sudo tee -a /etc/shells
      echo "$1 registered in /etc/shells"
    fi
  fi
}

__dotfiles_remove_line() { # filePath, lineString
  local TEMP
  TEMP=`mktemp`
  sed "$2" "$1" > "$TEMP"
  mv "$TEMP" "$1"
}

__dotfiles_download_extract_zip() { # url, targetDir, filePattern
  local TEMP
  TEMP=`mktemp`
  curl -L -o "${TEMP}" "$1"
  unzip -j -o "${TEMP}" "$3" -d "$2"
  rm "${TEMP}"
}

__dotfiles_download_extract_tgz() { # url, targetDir
  local TEMP
  TEMP=`mktemp`
  curl -L -o "${TEMP}" "$1"
  tar zxf "${TEMP}" -C "$2" --strip 1
  rm "${TEMP}"
}
