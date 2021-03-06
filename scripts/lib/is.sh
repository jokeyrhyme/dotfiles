#!/bin/sh

__dotfiles_is_brew_found() {
  if command -v brew > /dev/null 2>&1; then
    return 0
  fi
  return 1
}

__dotfiles_is_homebrew_found() {
  if __dotfiles_is_brew_found; then
    if __dotfiles_is_os_darwin; then
      return 0
    fi
  fi
  return 1
}

__dotfiles_is_linuxbrew_found() {
  if __dotfiles_is_brew_found; then
    if __dotfiles_is_os_linux; then
      return 0
    fi
  fi
  return 1
}

__dotfiles_is_os_darwin() {
  if [ $(uname -s) = "Darwin" ]; then
    return 0
  fi
  return 1
}

__dotfiles_is_os_linux() {
  if [ $(uname -s) = "Linux" ]; then
    return 0
  fi
  return 1
}

__dotfiles_is_os_wsl() {
  if [ -r /proc/version ]; then
    if $(grep -q Microsoft /proc/version); then
      return 0
    fi
  fi
  return 1
}
