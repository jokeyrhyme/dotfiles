#!/bin/sh

# combine files in ~/.ssh/config.d into ~/.ssh/config

if [ ! -d ~/.ssh ]; then
  # nothing to do, exit early
  exit 0;
fi

if [ ! -d ~/.ssh/config.d ]; then
  # nothing to do, exit early
  exit 0;
fi

if [ -f ~/.ssh/config ]; then
  # backup existing file
  mv ~/.ssh/config ~/.ssh/config.$(date -u +%s).bak
fi

touch ~/.ssh/config
for f in ~/.ssh/config.d/*
do
  NAME=$(basename "$f")
  # for some reason, these tests can't be ANDed with '-a'
  if [[ (("$NAME" > "/")) ]]; then
    if [[ (("$NAME" < ":")) ]]; then
      echo "$f"
      cat "$f" >> ~/.ssh/config
    fi
  fi
done

