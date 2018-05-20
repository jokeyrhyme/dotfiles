#! /bin/sh

set -e

pushd "$(dirname $0)/.." >/dev/null
. ./scripts/lib/is.sh
. ./scripts/lib/utils.sh
popd >/dev/null

__dotfiles_assert_in_path brew

if __dotfiles_is_brew_found; then
  echo "installing Hashicorp tools via Homebrew..."
  # https://www.hashicorp.com/#open-source-tools
  brew install packer terraform vault nomad consul
fi
