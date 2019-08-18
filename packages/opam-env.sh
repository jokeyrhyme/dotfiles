#!/bin/bash

if command -v opam >/dev/null 2>&1; then
  eval "$(opam config env)"
fi
