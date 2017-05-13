#!/bin/bash

if [ -d "${HOME}/.linuxbrew/bin" ]; then
  export PATH="${HOME}/.linuxbrew/bin:${PATH}"
  export INFOPATH="/home/ron/.linuxbrew/share/info:$INFOPATH"
  export MANPATH="/home/ron/.linuxbrew/share/man:$MANPATH"
fi
