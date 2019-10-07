#!/usr/bin/env bash

# https://github.com/nvm-sh/nvm
if [ -r "${HOME}/.nvm/nvm.sh" ]; then
  export NVM_DIR="${HOME}/.nvm"
  # shellcheck disable=SC1090
  . "${NVM_DIR}/nvm.sh"
fi

# https://github.com/jasongin/nvs
if [ -r "${HOME}/.nvs/nvs.sh" ]; then
  export NVS_HOME="${HOME}/.nvs"
  # shellcheck disable=SC1090
  . "${NVS_HOME}/nvs.sh"
fi
