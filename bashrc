#!/bin/bash
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# include user profile
pushd "$HOME" > /dev/null || exit 1
# shellcheck source=./profile
. ./.profile
popd > /dev/null || exit 1

# Path to the bash it configuration
export BASH_IT="$HOME/.bash_it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='minimal'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/xvzf/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# Load Bash It
pushd "$BASH_IT" > /dev/null || exit 1
# shellcheck disable=SC1091
. ./bash_it.sh
popd > /dev/null || exit 1

# custom `cd` command
cd() {
    builtin cd "$@"
    if [[ $- == *s* ]]; then
        # reading from stdin, so have a helpful `ls`
        # note that checking *i* for interactivity breaks cloudtoken
        ls
    fi
}

if [ "$(uname)" = "Darwin"  ]; then
  bash-it enable plugin osx > /dev/null 2>&1
fi

bash-it enable plugin git ssh > /dev/null 2>&1

# enable concurrent shell history
# https://opensource.com/article/18/5/bash-tricks
shopt -s histappend

