#!/bin/sh

set -e

pushd "$(dirname $0)/.." >/dev/null
. ./scripts/lib/utils.sh
popd >/dev/null

if which dnf >/dev/null 2>&1; then
  echo 'found dnf!'
  __dotfiles_force_mkdir ~/.local/share/fonts
  sudo dnf install -y google-droid-{sans,serif,sans-mono}-fonts
  sudo dnf install -y liberation-{mono,narrow,sans,serif}-fonts
fi

if which pacman >/dev/null 2>&1; then
  echo 'found pacman!'
  __dotfiles_force_mkdir ~/.local/share/fonts
  sudo pacman -Sy --needed --noconfirm ttf-{droid,liberation,ubuntu-font-family}
fi

if [ -d ~/.local/share/fonts ]; then
  USER_TTF_DIR=~/.local/share/fonts
  USER_OTF_DIR=$USER_TTF_DIR/opentype
  mkdir -p ${USER_OTF_DIR}
elif [ -d ~/Library/Fonts ]; then
  USER_OTF_DIR=~/Library/Fonts
  USER_TTF_DIR=${USER_OTF_DIR}
fi

if [ ${USER_OTF_DIR} ]; then
  ADOBE_CODE_RELEASES='https://github.com/adobe-fonts/source-code-pro/archive/'
  ADOBE_CODE_URL=${ADOBE_CODE_RELEASES}'2.030R-ro/1.050R-it.zip'
  __dotfiles_download_extract_zip "${ADOBE_CODE_URL}" "${USER_OTF_DIR}" "*.otf"
fi

if [ ${USER_TTF_DIR} ]; then
  NOTO_URL='https://noto-website.storage.googleapis.com/pkgs/Noto-hinted.zip'
  __dotfiles_download_extract_zip "${NOTO_URL}" "${USER_TTF_DIR}" "*.ttf"
fi

if which fc-cache >/dev/null 2>&1; then
  fc-cache -r
fi
