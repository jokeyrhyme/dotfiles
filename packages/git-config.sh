#!/bin/bash

set -e

if command -v git >/dev/null 2>&1; then
  echo "configuring git..."

  if ! git config --global --get user.email; then
    git config --global user.email "jokeyrhyme@gmail.com"
  fi
  if ! git config --global --get user.name; then
    git config --global user.name "Ron Waldon"
  fi

  if ! git config --global --get user.signingKey; then
    # https://keybase.io/jokeyrhyme
    git config --global user.signingKey "F96EC3B1"
  fi

  git config --global push.default "simple"

  if command -v gpg >/dev/null 2>&1; then
    git config --global gpg.program "gpg"
  else
    git config --global --unset gpg.program
  fi

  if command -v diff-so-fancy >/dev/null 2>&1; then
    if command -v less >/dev/null 2>&1; then
      git config --global core.pager "diff-so-fancy | less --tabs=2 -RFX"
    fi
  else
    git config --global --unset core.pager
  fi

  if command -v git-lfs >/dev/null 2>&1; then
    git lfs install
  fi

  git config --global color.ui "auto"

  # https://github.com/so-fancy/diff-so-fancy
  git config --global color.diff-highlight.oldNormal "red bold"
  git config --global color.diff-highlight.oldHighlight "red bold 52"
  git config --global color.diff-highlight.newNormal "green bold"
  git config --global color.diff-highlight.newHighlight "green bold 22"

  # https://about.gitlab.com/2016/12/08/git-tips-and-tricks/
  git config --global fetch.prune true
  git config --global rebase.autosquash true
  git config --global status.branch true
  git config --global status.short true
  git config --global status.submoduleSummary true

  # http://blog.kfish.org/2010/04/git-lola.html
  git config --global alias.lol "log --graph --decorate --pretty=oneline --abbrev-commit"
  git config --global alias.lola "log --graph --decorate --pretty=oneline --abbrev-commit --all"

  # http://psung.blogspot.com.au/2011/02/reducing-merge-headaches-git-meets.html
  git config --global merge.conflictstyle diff3
fi
