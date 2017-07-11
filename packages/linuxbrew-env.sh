#!/bin/bash

LINUXBREW_DIR=/home/linuxbrew/.linuxbrew

if [ -d "${LINUXBREW_DIR}/bin" ]; then
  export PATH="${LINUXBREW_DIR}/bin:${PATH}"
  export INFOPATH="${LINUXBREW_DIR}/share/info:$INFOPATH"
  export MANPATH="${LINUXBREW_DIR}/share/man:$MANPATH"
  export XDG_DATA_DIRS="${LINUXBREW_DIR}/share:$XDG_DATA_DIRS"
fi
