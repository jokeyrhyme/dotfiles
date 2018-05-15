#!/bin/sh

if which dnf > /dev/null 2>&1; then
  echo 'updating packages with dnf...'
  sudo dnf upgrade --obsoletes --allowerasing
elif which yum > /dev/null 2>&1; then
  echo 'updating packages with yum...'
  sudo yum upgrade -y
fi

pushd "$(dirname $0)/.." > /dev/null || exit 1
for updatesh in ./packages/*-update.sh; do
  # shellcheck disable=SC1090
  . "$updatesh"
done
popd > /dev/null || exit 1
