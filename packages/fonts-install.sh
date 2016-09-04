#!/bin/sh

set -e

. $(dirname $0)/../scripts/lib/utils.sh

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
  HACK_RELEASES='https://github.com/chrissimpkins/Hack/releases/download/'
  HACK_URL=${HACK_RELEASES}'v2.020/Hack-v2_020-otf.zip'
  ZIP=`mktemp`
  curl -L -o "${ZIP}" "${HACK_URL}"
  unzip -j -o "${ZIP}" *.otf -d ${USER_OTF_DIR}
  rm "${ZIP}"

  ADOBE_CODE_RELEASES='https://github.com/adobe-fonts/source-code-pro/archive/'
  ADOBE_CODE_URL=${ADOBE_CODE_RELEASES}'2.030R-ro/1.050R-it.zip'
  ZIP=`mktemp`
  curl -L -o "${ZIP}" "${ADOBE_CODE_URL}"
  unzip -j -o "${ZIP}" *.otf -d ${USER_OTF_DIR}
  rm "${ZIP}"

  FIRACODE_RELEASES='https://github.com/tonsky/FiraCode/releases/download/'
  FIRACODE_URL=${FIRACODE_RELEASES}'1.201/FiraCode_1.201.zip'
  ZIP=`mktemp`
  curl -L -o "${ZIP}" "${FIRACODE_URL}"
  unzip -j -o "${ZIP}" *.otf -d ${USER_OTF_DIR}
  rm "${ZIP}"

  HASKLIG_RELEASES='https://github.com/i-tu/Hasklig/releases/download/'
  HASKLIG_URL=${HASKLIG_RELEASES}'v1.0-beta/Hasklig-1.0-Beta.zip'
  ZIP=`mktemp`
  curl -L -o "${ZIP}" "${HASKLIG_URL}"
  unzip -j -o "${ZIP}" *.otf -d ${USER_OTF_DIR}
  rm "${ZIP}"
fi

if [ ${USER_TTF_DIR} ]; then
  OVERPASS_RELEASES='https://github.com/RedHatBrand/overpass/releases/download/'
  OVERPASS_URL=${OVERPASS_RELEASES}'2.0/overpass-fonts-ttf-2.zip'
  ZIP=`mktemp`
  curl -L -o "${ZIP}" "${OVERPASS_URL}"
  unzip -j -o "${ZIP}" *.ttf -d ${USER_TTF_DIR}
  rm "${ZIP}"
fi

if which fc-cache > /dev/null 2>&1; then
  fc-cache -r
fi
