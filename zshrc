# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#ZSH_THEME="random"
#ZSH_THEME="kphoen"
#ZSH_THEME="kolo"
#ZSH_THEME="steeef"
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

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)

# load in OS X plugins
if [ "${TERM_PROGRAM}" = "Apple_Terminal" ]; then
  plugins=(osx terminalapp $plugins)
  if [ -x /usr/local/bin/brew ]; then
    export HOMEBREW_BUILD_FROM_SOURCE=1
    export PATH=/usr/local/bin:/usr/local/sbin:$PATH
  fi
fi

# run through list of commands and pull in matching plugins
PLUGIN_CMDS="yum brew" # package managers
PLUGIN_CMDS="git git-flow svn ${PLUGIN_CMDS}" # version control
PLUGIN_CMDS="tmux ${PLUGIN_CMDS}" # other commands
for p in $PLUGIN_CMDS
do
  if whence $p > /dev/null; then
    plugins=($p $plugins)
  fi
done

# rbenv and ruby
if [ -d ~/.rbenv ]; then
  plugins=(gem bundler rbenv rake ruby vagrant $plugins)
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# nvm and node.js
if [ -f ~/.nvm/nvm.sh ]; then
  plugins=(nvm npm $plugins)
  source ~/.nvm/nvm.sh
fi

# load in other plugins

plugins=(vi-mode battery encode64 $plugins)

source $ZSH/oh-my-zsh.sh

# enable incremental search
bindkey "^R" history-incremental-search-backward

export GREP_OPTIONS="--exclude=.svn --exclude=.git ${GREP_OPTIONS}"

export LANGUAGE="en_AU:en_GB:en_US:en"

# Java on OS X
if [ -f /usr/libexec/java_home -a -x /usr/libexec/java_home ]; then
  export JAVA_HOME=$(/usr/libexec/java_home)
fi

# Android SDK
if [ -d /opt/android-sdk ]; then
  export PATH=$PATH:/opt/android-sdk/platform-tools:/opt/android-sdk/tools
fi

# check if connecting via SSH
if [ -n "$SSH_CLIENT" ]; then
  # check if connected locally
  if [[ "$SSH_CLIENT" == *::1* ]]; then
    export DISPLAY=:0
  fi
fi

# Customize to your needs...
#export PATH=/usr/lib64/qt-3.3/bin:/usr/lib64/ccache:/usr/local/bin:/usr/bin:/bin:/home/ron/bin:/usr/local/sbin:/usr/sbin:/opt/android-sdk/tools:/opt/android-sdk/platform-tools:/usr/local/bin:/opt/npm/bin:/home/ron/bin:/opt/android-sdk/tools:/opt/android-sdk/platform-tools:/usr/local/bin:/opt/npm/bin
