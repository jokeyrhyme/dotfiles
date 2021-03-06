#! /usr/bin/env bash

export CLICOLOR=true
export LANGUAGE="en_AU:en_GB:en_US:en"

pushd "$HOME" >/dev/null || exit 1
for envsh in ./.dotfiles/packages/*-env.sh; do
  # shellcheck disable=SC1090
  . "$envsh"
done
popd >/dev/null || exit 1

if command -v jokeyrhyme-dotfiles >/dev/null 2>&1; then
  # shellcheck disable=SC2091
  $(jokeyrhyme-dotfiles env || true)
fi

if [ -d /etc/xdg ]; then
  export XDG_DATA_DIRS=${XDG_DATA_DIRS}:/usr/local/share:/usr/share
fi

# http://www.linuxfromscratch.org/lfs/view/stable/chapter04/aboutsbus.html
export MAKEFLAGS='-j2'
if [ -r /proc/cpuinfo ]; then
  # use all CPUs, but leave one spare for system responsiveness
  export MAKEFLAGS='-j'$(($(grep -c ^processor </proc/cpuinfo) - 1))
fi

# http://www.linuxfromscratch.org/hints/downloads/files/optimization.txt
export CFLAGS="-Os -march=native"
export CXXFLAGS="${CFLAGS}"

# https://opensource.com/article/18/5/advanced-use-less-text-file-viewer
if type less >/dev/null 2>&1; then
  export LESS='-C -M -I -j 10 -x 2 -# 4 -R'
  export PAGER=less
fi

if type pkg-config >/dev/null 2>&1; then
  export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/local/lib/pkgconfig
  if [ -d /home/linuxbrew/.linuxbrew/lib/pkgconfig ]; then
    export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/home/linuxbrew/.linuxbrew/lib/pkgconfig
  fi
  if [ -d /usr/lib/x86_64-linux-gnu/pkgconfig ]; then
    export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/lib/x86_64-linux-gnu/pkgconfig
  fi
fi

# Java on OS X
if [ -f /usr/libexec/java_home ] && [ -x /usr/libexec/java_home ]; then
  if /usr/libexec/java_home &>/dev/null; then
    JAVA_HOME=$(/usr/libexec/java_home)
    export JAVA_HOME
  fi
fi

# Android SDK
if [ -d /opt/android-sdk ]; then
  export ANDROID_HOME=/opt/android-sdk
fi
if [ -d /Applications/Android\ Studio.app/sdk ]; then
  export ANDROID_HOME=/Applications/Android\ Studio.app/sdk
fi
if [ -d ~/Library/Android/sdk ]; then
  export ANDROID_HOME=~/Library/Android/sdk
fi
if [ -d ~/Android/Sdk ]; then
  export ANDROID_HOME=~/Android/Sdk
fi
export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools

# added by travis gem
# shellcheck disable=SC1091
[ -f /Users/ron/.travis/travis.sh ] && . /Users/ron/.travis/travis.sh

### Added by the Heroku Toolbelt
if [ -d /usr/local/heroku/bin ]; then
  export PATH="/usr/local/heroku/bin:$PATH"
fi

# check if connecting via SSH
if [ -n "$SSH_CLIENT" ]; then
  # check if connected locally
  if [[ $SSH_CLIENT == *::1* ]]; then
    export DISPLAY=:0
  fi
fi

# set defaults for docker
if type docker >/dev/null 2>&1; then
  if [ -w /var/run/docker.sock ]; then
    export DOCKER_HOST=unix:///var/run/docker.sock
  fi
fi
