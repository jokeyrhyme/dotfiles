#!/bin/bash

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/is.sh
popd > /dev/null

EXTENSIONS=(
  "Zen"
  "atom-wrap-in-tag"
  "autocomplete-modules"
  "autocomplete-paths"
  "editorconfig"
  "emmet"
  "file-icons"
  "go-debug"
  "go-plus"
  "go-signature-statusbar"
  "hyperclick"
  "language-babel"
  "language-docker"
  "language-markdown"
  "language-swift"
  "language-terraform"
  "linter"
  "linter-alex"
  "linter-csslint"
  "linter-eslint"
  "linter-htmlhint"
  "linter-markdown"
  "linter-php"
  "linter-proselint"
  "linter-shellcheck"
  "linter-write-good"
  "merge-conflicts"
  "minimap"
  "minimap-find-and-replace"
  "minimap-git-diff"
  "minimap-linter"
  "minimap-selection"
  "prettier-atom"
)

UNINSTALL_EXTENSIONS=()

if __dotfiles_is_os_wsl; then
  echo "WSL detected, skipping ..."

elif which apm > /dev/null 2>&1; then
  INSTALLED_EXTENSIONS=$(apm ls --bare --intalled --packaged)

  echo "Installing extensions for Atom..."
  for EXTENSION in "${EXTENSIONS[@]}"
  do
    if ! echo "${INSTALLED_EXTENSIONS}" | grep "${EXTENSION}" > /dev/null 2>&1; then
      apm install --quiet --production "$EXTENSION"
    fi
  done

  echo "Uninstalling unused extensions for Atom..."
  for EXTENSION in "${UNINSTALL_EXTENSIONS[@]}"
  do
    if echo "${INSTALLED_EXTENSIONS}" | grep " ${EXTENSION}@" > /dev/null 2>&1; then
      apm uninstall --hard "$EXTENSION"
    fi
  done

  echo 'updating Atom packages...'
  apm upgrade --confirm false
fi
