#!/bin/sh

set -e

HACK_RELEASES='https://github.com/chrissimpkins/Hack/releases/download/'
ADOBE_CODE_RELEASES='https://github.com/adobe-fonts/source-code-pro/archive/'

if which dnf > /dev/null 2>&1; then
  echo 'found dnf!'
  sudo dnf install -y adobe-source-{code,sans}-pro-fonts
  sudo dnf install -y google-droid-{sans,serif,sans-mono}-fonts
  sudo dnf install -y liberation-{mono,narrow,sans,serif}-fonts
fi

if which pacman > /dev/null 2>&1; then
  echo 'found pacman!'
  sudo pacman -Sy --needed --noconfirm adobe-source-{code,sans,serif}-pro-fonts
  sudo pacman -Sy --needed --noconfirm ttf-{droid,liberation,ubuntu-font-family}
fi

if [ -d ~/Library/Fonts ]; then
  HACK_URL=${HACK_RELEASES}'v2.013/Hack-v2_013-otf.zip'
  ZIP=`mktemp`
  curl -L -o "${ZIP}" "${HACK_URL}"
  unzip -o "${ZIP}" -d ~/Library/Fonts/
  rm "${ZIP}"

  ADOBE_CODE_URL=${ADOBE_CODE_RELEASES}'2.010R-ro/1.030R-it.zip'
  ZIP=`mktemp`
  curl -L -o "${ZIP}" "${ADOBE_CODE_URL}"
  unzip -j -o "${ZIP}" *.otf -d ~/Library/Fonts/
  rm "${ZIP}"
fi

if which fc-cache > /dev/null 2>&1; then
  fc-cache -r
fi
