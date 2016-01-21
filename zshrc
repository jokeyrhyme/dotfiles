#!/bin/zsh

# include system profile
if [ -f /etc/profile ]; then
  . /etc/profile
fi
# include user profile
# shellcheck source=./profile
. $HOME/.profile

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

# load in other plugins

plugins=(vi-mode battery encode64 $plugins)

. "$ZSH/oh-my-zsh.sh"

# enable incremental search
bindkey "^R" history-incremental-search-backward

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
