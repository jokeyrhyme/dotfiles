# dotfiles

## Dependencies

### OS X

- Xcode, run at least once to agree to the license


## Installation

1. clone this repository into a hidden directory

    ```sh
    git clone https://github.com/jokeyrhyme/dotfiles.git ~/.dotfiles
    ```

2. run the ansible playbooks (it'll prompt for `sudo` passphrase)

    ```sh
    ansible-playbook -K -c local -i ~/.dotfiles/playbooks/localhost ~/.dotfiles/playbooks/general.yml
    ```

3. if on OS X, make sure you install [Homebrew](http://brew.sh/)

    ```sh
    sh ~/.dotfiles/packages/homebrew-install.sh
    ```

4. run any of the following as you wish

    ```sh
    sh ~/.dotfiles/packages/git-install.sh
    sh ~/.dotfiles/packages/fonts-install.sh
    sh ~/.dotfiles/packages/zsh-install.sh # requires git
    sh ~/.dotfiles/packages/nodejs-install.sh # requires git
    sh ~/.dotfiles/packages/ruby-install.sh # requires git
    sh ~/.dotfiles/packages/vim-install.sh # requires git, ruby
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
