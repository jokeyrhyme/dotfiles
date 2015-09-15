# dotfiles

## Dependencies

### OS X

- Xcode, run at least once to agree to the license


## Installation

1. clone this repository into a hidden directory

    ```sh
    git clone https://github.com/jokeyrhyme/dotfiles.git ~/.dotfiles
    ```

2. install additional package managers depending on your OS

    ```sh
    sh ~/.dotfiles/packages/aurget-install.sh # ArchLinux-only, required
    sh ~/.dotfiles/packages/homebrew-install.sh # OSX-only, required
    ```

3. run any of the following as you wish

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


## Updating

```sh
cd ~/.dotfiles
git pull
sh ~/.dotfiles/scripts/update.sh
```

## Note: sudo

I avoid `sudo` usage where possible. I currently need it for:

- system package installation (e.g. pacman, apt, yum)
- ensuring installed `zsh` is in the `/etc/shells` file
- setting `zsh` as the default shell for the current user
