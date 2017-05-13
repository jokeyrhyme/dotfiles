#!/bin/sh

if which apm-beta > /dev/null 2>&1; then
  if ! type apm > /dev/null 2>&1; then
    alias apm="apm-beta"
  fi
fi

if which atom-beta > /dev/null 2>&1; then
  if ! type atom > /dev/null 2>&1; then
    alias atom="atom-beta"
  fi
fi
