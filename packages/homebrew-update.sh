#!/bin/sh

set -e

pushd "$(dirname $0)/.." >/dev/null
. ./scripts/lib/is.sh
popd >/dev/null

# brew cannot update zsh if it is locked down
if __dotfiles_is_homebrew_found; then
  chmod g+w /usr/local/share/zsh /usr/local/share/zsh/site-functions
fi

if __dotfiles_is_brew_found; then
  echo 'updating Homebrew and packages...'
  brew update || true # may fail if a tap is inaccessible
  brew upgrade && brew cleanup
fi

# zsh likes to be locked down for normal use
if __dotfiles_is_homebrew_found; then
  chmod g-w /usr/local/share/zsh /usr/local/share/zsh/site-functions
fi

if __dotfiles_is_homebrew_found; then
  if which brew-cask.rb >/dev/null 2>&1; then
    echo 'updating Homebrew Cask and packages...'

    for f in $(brew cask outdated | cut -f 1 -d ''); do
      brew cask install --force "$f"
    done
    brew cask cleanup
  fi
fi
