#!/bin/sh

if [ ! -d ~/.nave ]; then
  git clone git://github.com/isaacs/nave.git ~/.nave
fi

if ! $(type node > /dev/null); then
  echo 'now run "sudo ~/.nave/nave.sh usemain stable"'
fi
