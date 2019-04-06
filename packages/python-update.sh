#!/usr/bin/env sh

set -e

PIPS=(
  "pip2"
  "pip3"
)

PIP_LIBS=(
  "boto"
  "botocore"
  "neovim"
  "requests"
)

PIP2_TOOLS=(
  "ansible"
  "ansible-lint"
  "ansible-vault"
  "virtualenv"
  "virtualenvwrapper"
)

PIP3_TOOLS=(
  "autopep8"
  "cloudtoken"
  "pylint"
  "twine"
  "virtualenv"
  "virtualenvwrapper"
)

for PIP in "${PIPS[@]}"; do
  if which "${PIP}" >/dev/null 2>&1; then
    echo "updating ${PIP} packages ..."
    OUTDATED=$(${PIP} list --outdated --format=freeze | cut -d = -f 1)
    for PACKAGE in ${OUTDATED}; do
      ${PIP} install --upgrade --user ${PACKAGE}
    done

    PIP_INSTALLED=$(${PIP} list --format=freeze | cut -d = -f 1)

    echo "installing favourite ${PIP} libraries ..."
    for PIP_LIB in "${PIP_LIBS[@]}"; do
      if ! echo "${PIP_INSTALLED}" | grep "${PIP_LIB}@" >/dev/null 2>&1; then
        ${PIP} install --upgrade --user "${PIP_LIB}"
      fi
    done

    if [ "${PIP}" = "pip2" ]; then
      echo "installing favourite ${PIP} tools ..."
      for PIP2_TOOL in "${PIP2_TOOLS[@]}"; do
        if ! echo "${PIP_INSTALLED}" | grep "${PIP2_TOOL}@" >/dev/null 2>&1; then
          ${PIP} install --upgrade --user "${PIP2_TOOL}"
        fi
      done
    fi

    if [ "${PIP}" = "pip3" ]; then
      echo "installing favourite ${PIP} tools ..."
      for PIP3_TOOL in "${PIP3_TOOLS[@]}"; do
        if ! echo "${PIP_INSTALLED}" | grep "${PIP3_TOOL}@" >/dev/null 2>&1; then
          ${PIP} install --upgrade --user "${PIP3_TOOL}"
        fi
      done
    fi
  fi
done
