#!/bin/bash

# ruby
if [ -d ~/.gem/ruby/2.0.0/bin ]; then
  export PATH="$HOME/.gem/ruby/2.0.0/bin:$PATH"
fi
if [ -d ~/.gem/ruby/2.1.0/bin ]; then
  export PATH="$HOME/.gem/ruby/2.1.0/bin:$PATH"
fi

# rbenv
if [ -x ~/.rbenv/bin/rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

