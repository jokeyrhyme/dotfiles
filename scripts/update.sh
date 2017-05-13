#!/bin/sh

if which dnf > /dev/null 2>&1; then
  echo 'updating packages with dnf...'
  sudo dnf upgrade --obsoletes --allowerasing
elif which yum > /dev/null 2>&1; then
  echo 'updating packages with yum...'
  sudo yum upgrade -y
fi

if which pacman > /dev/null 2>&1; then
  echo 'updating packages with pacman...'
  sudo pacman -Syu

  if which aurget > /dev/null 2>&1; then
    echo 'updating packages with aurget...'
    aurget -Syu --noedit
  fi
fi

pushd "$(dirname $0)/.." > /dev/null
for updatesh in ./packages/*-update.sh; do
  # shellcheck disable=SC1090
  . "$updatesh"
done
popd > /dev/null
