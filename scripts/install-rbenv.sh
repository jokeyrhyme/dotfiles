#!/bin/sh

if [ ! -d ~/.rbenv ]; then
  git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
fi

if [ ! -d ~/.rbenv/plugins/ruby-build ]; then
  git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

if [ ! -d ~/.rbenv/cache ]; then
  mkdir ~/.rbenv/cache
fi

if ! $(type rbenv > /dev/null); then
  echo 're-login and "rbenv" will be available!'
fi
