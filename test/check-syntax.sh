#!/bin/sh

for SH_SCRIPT in $(find $(dirname $0)/../ -name '*.sh')
do
  bash -n ${SH_SCRIPT}
  zsh -n ${SH_SCRIPT}
done
