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
  if [ -n "$DISPLAY" ]; then
    alias vim="gvim"
    alias gvim="gvim --remote-tab-silent"
  fi
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
  if [ -x /usr/local/bin/brew ]; then
    export PATH=/usr/local/sbin:$PATH
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

# nvm
if [ -f ~/.nvm/nvm.sh ]; then
  source ~/.nvm/nvm.sh
  plugins=(node npm $plugins)
fi

# https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md

# npm
if [ -d ~/.npm-packages ]; then
  if whence npm > /dev/null; then
    NPM_PACKAGES="${HOME}/.npm-packages"
    npm config set prefix $NPM_PACKAGES
    #export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
    export NODE_PATH="$NPM_PACKAGES/lib/node_modules"
    export PATH="$NPM_PACKAGES/bin:$PATH"
    unset MANPATH
    export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
  fi
fi

# load in other plugins

plugins=(vi-mode battery encode64 $plugins)

source "$ZSH/oh-my-zsh.sh"

# enable incremental search
bindkey "^R" history-incremental-search-backward

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
if [ -d ~/Android/Sdk ]; then
  export ANDROID_HOME=~/Android/Sdk
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
  if type boot2docker > /dev/null 2>&1; then
    $(boot2docker shellinit)
  fi
  if type docker-machine > /dev/null 2>&1; then
    if docker-machine ip > /dev/null 2>&1; then
      eval "$(docker-machine env)"
    fi
  fi
  if [ -w /var/run/docker.sock ]; then
    export DOCKER_HOST=unix:///var/run/docker.sock
  fi
fi

source ~/.dotfiles/packages/golang-env.sh
