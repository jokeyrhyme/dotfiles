#!/bin/sh

set -e

pushd "$(dirname $0)/.." > /dev/null
. ./scripts/lib/utils.sh
popd > /dev/null

if which dnf > /dev/null 2>&1; then
  echo 'found dnf!'
  __dotfiles_force_mkdir ~/.local/share/fonts
  sudo dnf install -y google-droid-{sans,serif,sans-mono}-fonts
  sudo dnf install -y liberation-{mono,narrow,sans,serif}-fonts
fi

if which pacman > /dev/null 2>&1; then
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

  FIRACODE_RELEASES='https://github.com/tonsky/FiraCode/releases/download/'
  FIRACODE_URL=${FIRACODE_RELEASES}'1.204/FiraCode_1.204.zip'
  __dotfiles_download_extract_zip "${FIRACODE_URL}" "${USER_OTF_DIR}" "*.otf"

  FIRA_RELEASES='https://github.com/mozilla/Fira/archive/'
  FIRA_URL=${FIRA_RELEASES}'4.202.zip'
  __dotfiles_download_extract_zip "${FIRA_URL}" "${USER_OTF_DIR}" "*.otf"

  HASKLIG_RELEASES='https://github.com/i-tu/Hasklig/releases/download/'
  HASKLIG_URL=${HASKLIG_RELEASES}'1.1/Hasklig-1.1.zip'
  __dotfiles_download_extract_zip "${HASKLIG_URL}" "${USER_OTF_DIR}" "*.otf"

  OVERPASS_RELEASES='https://github.com/RedHatBrand/Overpass/releases/download/'
  OVERPASS_URL=${OVERPASS_RELEASES}'3.0.2/overpass-desktop-fonts.zip'
  __dotfiles_download_extract_zip "${OVERPASS_URL}" "${USER_OTF_DIR}" "*.otf"
fi

if [ ${USER_TTF_DIR} ]; then
  HACK_RELEASES='https://github.com/source-foundry/Hack/releases/download/'
  HACK_URL=${HACK_RELEASES}'v3.001/Hack-v3.001-ttf.zip'
  __dotfiles_download_extract_zip "${HACK_URL}" "${USER_TTF_DIR}" "*.ttf"

  NOTO_URL='https://noto-website.storage.googleapis.com/pkgs/Noto-hinted.zip'
  __dotfiles_download_extract_zip "${NOTO_URL}" "${USER_TTF_DIR}" "*.ttf"
fi

if which fc-cache > /dev/null 2>&1; then
  fc-cache -r
fi
