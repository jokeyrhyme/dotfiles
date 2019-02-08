# dotfiles [![Build Status](https://travis-ci.org/jokeyrhyme/dotfiles.svg?branch=master)](https://travis-ci.org/jokeyrhyme/dotfiles)

## Status

This project is best paired with [`jokeyrhyme-dotfiles`](https://github.com/jokeyrhyme/dotfiles-rs).
Eventually, this project will contain preferences, and all scripts will be removed in favour of `jokeyrhyme-dotfiles`.

## Dependencies

### OS X

* Xcode, run at least once to agree to the license

## Installation

1.  clone this repository into a hidden directory

    ```sh
    git clone https://github.com/jokeyrhyme/dotfiles.git ~/.dotfiles
    ```

2.  (optional) install [Homebrew](https://brew.sh)

3.  run any of the following as you wish

    ```sh
    sh ~/.dotfiles/packages/git-install.sh
    sh ~/.dotfiles/packages/mercurial-install.sh
    sh ~/.dotfiles/packages/fonts-install.sh
    sh ~/.dotfiles/packages/zsh-install.sh # requires git
    sh ~/.dotfiles/packages/nodejs-install.sh # requires git
    sh ~/.dotfiles/packages/ruby-install.sh # requires git
    sh ~/.dotfiles/packages/vim-install.sh # requires git
    sh ~/.dotfiles/packages/atom-install.sh
    ```

### Debian / Ubuntu / etc

* these systems [symlink `/bin/sh` to `dash`](https://wiki.ubuntu.com/DashAsBinSh) rather than `bash`

* as such, whilst examples here use `sh`, you will have to use `bash` explicitly

## Updating

```sh
cd ~/.dotfiles
git pull
sh ~/.dotfiles/scripts/update.sh
```

## Note: sudo

I avoid `sudo` usage where possible. I currently need it for:

* system package installation (e.g. pacman, apt, yum)
* ensuring installed `zsh` is in the `/etc/shells` file
* setting `zsh` as the default shell for the current user
