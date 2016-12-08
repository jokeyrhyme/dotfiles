#!/bin/sh

if which git > /dev/null 2>&1; then
  echo "configuring git..."

  git config --global user.email "jokeyrhyme@gmail.com"
  git config --global user.name "Ron Waldon"

  # https://keybase.io/jokeyrhyme
  git config --global user.signingKey "F96EC3B1"

  git config --global push.default "simple"

  if type gpg2 > /dev/null 2>&1; then
    git config --global gpg.program "gpg2"
  else
    git config --global --unset gpg.program
  fi

  git config --global color.ui "auto"

  # https://about.gitlab.com/2016/12/08/git-tips-and-tricks/
  git config --global fetch.prune true
  git config --global rebase.autosquash true
  git config --global status.submoduleSummary true

  # http://blog.kfish.org/2010/04/git-lola.html
  git config --global alias.lol "log --graph --decorate --pretty=oneline --abbrev-commit"
  git config --global alias.lola "log --graph --decorate --pretty=oneline --abbrev-commit --all"
fi
