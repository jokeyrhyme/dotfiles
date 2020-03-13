#! /usr/bin/env sh

pushd "$(dirname $0)/.." >/dev/null || exit 1
. ./scripts/lib/is.sh
. ./scripts/lib/utils.sh
popd >/dev/null || exit 1

if command -v dnf >/dev/null 2>&1; then
  echo 'updating packages with dnf...'
  sudo dnf upgrade --obsoletes --allowerasing
elif command -v yum >/dev/null 2>&1; then
  echo 'updating packages with yum...'
  sudo yum upgrade -y
fi

pushd "$(dirname $0)/.." >/dev/null || exit 1
for updatesh in ./packages/*-update.sh; do
  # shellcheck disable=SC1090
  . "$updatesh"
done
popd >/dev/null || exit 1

if command -v cargo >/dev/null 2>&1; then
  cargo install jokeyrhyme-dotfiles tuning || true
fi
if [ -r ~/.dotfiles/tuning/main.toml ]; then
  if command -v tuning >/dev/null 2>&1; then
    if __dotfiles_is_os_darwin; then
      mkdir -p ~/Library/Preferences
      __dotfiles_force_symlink ~/.dotfiles/tuning ~/Library/Preferences/tuning
    else # linux
      mkdir -p ~/.config
      __dotfiles_force_symlink ~/.dotfiles/tuning ~/.config/tuning
    fi
    RUST_BACKTRACE=1 tuning || true
  fi
fi
if command -v jokeyrhyme-dotfiles >/dev/null 2>&1; then
  RUST_BACKTRACE=1 jokeyrhyme-dotfiles all || true
fi
