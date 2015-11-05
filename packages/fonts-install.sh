#!/bin/sh

set -e

. $(dirname $0)/../scripts/lib/utils.sh

HACK_RELEASES='https://github.com/chrissimpkins/Hack/releases/download/'
ADOBE_CODE_RELEASES='https://github.com/adobe-fonts/source-code-pro/archive/'
OVERPASS_RELEASES='https://github.com/RedHatBrand/overpass/releases/download/'

if which dnf > /dev/null 2>&1; then
  echo 'found dnf!'
  __dotfiles_force_mkdir ~/.local/share/fonts
  sudo dnf install -y adobe-source-{code,sans}-pro-fonts
  sudo dnf install -y google-droid-{sans,serif,sans-mono}-fonts
  sudo dnf install -y liberation-{mono,narrow,sans,serif}-fonts
fi

if which pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  __dotfiles_force_mkdir ~/.local/share/fonts
  sudo pacman -Sy --needed --noconfirm adobe-source-{code,sans,serif}-pro-fonts
  sudo pacman -Sy --needed --noconfirm ttf-{droid,liberation,ubuntu-font-family}
fi

if [ -d ~/.local/share/fonts ]; then
  HACK_URL=${HACK_RELEASES}'v2.018/Hack-v2_018-ttf.zip'
  ZIP=`mktemp`
  curl -L -o "${ZIP}" "${HACK_URL}"
  unzip -o "${ZIP}" -d ~/.local/share/fonts/
  rm "${ZIP}"

  OVERPASS_URL=${OVERPASS_RELEASES}'2.0/overpass-fonts-ttf-2.zip'
  ZIP=`mktemp`
  curl -L -o "${ZIP}" "${OVERPASS_URL}"
  unzip -o "${ZIP}" *.ttf -d ~/.local/share/fonts/
  rm "${ZIP}"
fi

if [ -d ~/Library/Fonts ]; then
  HACK_URL=${HACK_RELEASES}'v2.018/Hack-v2_018-otf.zip'
  ZIP=`mktemp`
  curl -L -o "${ZIP}" "${HACK_URL}"
  unzip -o "${ZIP}" -d ~/Library/Fonts/
  rm "${ZIP}"

  ADOBE_CODE_URL=${ADOBE_CODE_RELEASES}'2.010R-ro/1.030R-it.zip'
  ZIP=`mktemp`
  curl -L -o "${ZIP}" "${ADOBE_CODE_URL}"
  unzip -j -o "${ZIP}" *.otf -d ~/Library/Fonts/
  rm "${ZIP}"

  OVERPASS_URL=${OVERPASS_RELEASES}'2.0/overpass-fonts-ttf-2.zip'
  ZIP=`mktemp`
  curl -L -o "${ZIP}" "${OVERPASS_URL}"
  unzip -o "${ZIP}" *.ttf -d ~/Library/Fonts/
  rm "${ZIP}"
fi

if which fc-cache > /dev/null 2>&1; then
  fc-cache -r
fi
