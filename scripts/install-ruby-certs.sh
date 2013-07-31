#!/bin/sh
# https://gist.github.com/mislav/5026283
curl -fsSL curl.haxx.se/ca/cacert.pem \
  -o "$(ruby -ropenssl -e 'puts OpenSSL::X509::DEFAULT_CERT_FILE')"
