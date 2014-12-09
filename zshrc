# include system profile
if [ -f /etc/profile ]; then
  source /etc/profile
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="pure"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# vim, gvim and MacVim
# TODO: detect vim first
if [ ! "$EDITOR" ]; then
  export EDITOR=$(which vim)
fi
if whence gvim > /dev/null; then
  alias vim="gvim"
  alias gvim="gvim --remote-tab-silent"
fi
if whence mvim > /dev/null; then
  alias vim="mvim"
  alias mvim="mvim --remote-tab-silent"
fi

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)

# load in OS X plugins
if [ "${TERM_PROGRAM}" = "Apple_Terminal" ]; then
  plugins=(osx terminalapp $plugins)
  if [ -x /opt/homebrew/bin/brew ]; then
    export HOMEBREW_BUILD_FROM_SOURCE=1
    export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
  fi
fi

# run through list of commands and pull in matching plugins
PLUGIN_CMDS=(brew bundler gem npm pip yum) # package managers
PLUGIN_CMDS=(git git-flow svn ${PLUGIN_CMDS}) # version control
PLUGIN_CMDS=(go node ruby rbenv ${PLUGIN_CMDS}) # languages
PLUGIN_CMDS=(docker gpg-agent rake tmux vagrant ${PLUGIN_CMDS}) # other commands
for p in $PLUGIN_CMDS
do
  if whence $p > /dev/null; then
    plugins=($p $plugins)
  fi
done

# ruby
if [ -d ~/.gem/ruby/2.0.0/bin ]; then
  export PATH="$HOME/.gem/ruby/2.0.0/bin:$PATH"
fi
if [ -d ~/.gem/ruby/2.1.0/bin ]; then
  export PATH="$HOME/.gem/ruby/2.1.0/bin:$PATH"
fi

# rbenv
if [ -x ~/.rbenv/bin/rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# load in other plugins

plugins=(vi-mode battery encode64 $plugins)

source "$ZSH/oh-my-zsh.sh"

# enable incremental search
bindkey "^R" history-incremental-search-backward

export GREP_OPTIONS="--exclude=.svn --exclude=.git ${GREP_OPTIONS}"

export LANGUAGE="en_AU:en_GB:en_US:en"

# Java on OS X
if [ -f /usr/libexec/java_home -a -x /usr/libexec/java_home ]; then
  if /usr/libexec/java_home &> /dev/null; then
    export JAVA_HOME=$(/usr/libexec/java_home)
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
export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools

# check if connecting via SSH
if [ -n "$SSH_CLIENT" ]; then
  # check if connected locally
  if [[ "$SSH_CLIENT" == *::1* ]]; then
    export DISPLAY=:0
  fi
fi

# custom `cd` command
cd() { builtin cd "$@" && ls; }

# added by travis gem
[ -f /Users/ron/.travis/travis.sh ] && source /Users/ron/.travis/travis.sh

### Added by the Heroku Toolbelt
if [ -d /usr/local/heroku/bin ]; then
  export PATH="/usr/local/heroku/bin:$PATH"
fi

# set defaults for docker
if whence docker > /dev/null; then
  if whence boot2docker > /dev/null; then
    $(boot2docker shellinit)
  else
    export DOCKER_HOST=tcp://localhost:2375
    export DOCKER_CERT_PATH=~/.boot2docker/certs/boot2docker-vm
    export DOCKER_TLS_VERIFY=1
  fi
fi

# go
if whence go > /dev/null; then
  GO=$(whence go)
  if [ -n "$GO" ]; then
    export GOROOT=$(dirname $(dirname $GO))
    if [ -h "$GO" ]; then
      PLATFORM=$(uname -s)
      if [ "$PLATFORM" = 'Linux' ]; then
        GO_SYM=$(readlink -f $GO)
      fi
      if [ "$PLATFORM" = 'Darwin' ]; then
        GO_SYM=$(readlink $GO)
      fi
      if [ -n "$GO_SYM" ]; then
        if [[ $GO_SYM == ..* ]]; then
          GO_SYM=$(dirname $GO)/$GO_SYM
        fi
        export GOROOT=$(dirname $(dirname $GO_SYM))
      fi
    fi
    mkdir -p "$HOME"/Projects/GOPATH/bin
    if whence brew > /dev/null; then
      export GOROOT=/opt/homebrew/opt/go/libexec
    fi
    export GOPATH=$HOME/Projects/GOPATH
    export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
  fi
fi
