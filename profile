#!/bin/bash

export CLICOLOR=true
export LANGUAGE="en_AU:en_GB:en_US:en"

pushd "$HOME" > /dev/null
. ./.dotfiles/packages/atom-env.sh
. ./.dotfiles/packages/homebrew-env.sh
. ./.dotfiles/packages/nodejs-env.sh
. ./.dotfiles/packages/ruby-env.sh
. ./.dotfiles/packages/vim-env.sh
. ./.dotfiles/packages/vscode-env.sh
popd > /dev/null

# Java on OS X
if [ -f /usr/libexec/java_home ] && [ -x /usr/libexec/java_home ]; then
  if /usr/libexec/java_home &> /dev/null; then
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
[ -f /Users/ron/.travis/travis.sh ] && . /Users/ron/.travis/travis.sh

### Added by the Heroku Toolbelt
if [ -d /usr/local/heroku/bin ]; then
  export PATH="/usr/local/heroku/bin:$PATH"
fi

# check if connecting via SSH
if [ -n "$SSH_CLIENT" ]; then
  # check if connected locally
  if [[ "$SSH_CLIENT" == *::1* ]]; then
    export DISPLAY=:0
  fi
fi

# set defaults for docker
if type docker > /dev/null 2>&1; then
  if [ -w /var/run/docker.sock ]; then
    export DOCKER_HOST=unix:///var/run/docker.sock
  fi
fi
