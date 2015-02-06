# dotfiles

## Dependencies


### Ansible

You will need to have ansible installed (which requires Python 2).

#### `apt`-based Linux: Debian, Ubuntu, etc

```sh
sudo apt-get install python-pip python2.7-dev python-apt
sudo pip install --upgrade ansible
```

#### `yum`-based Linux: Fedora, RedHat, Amazon, etc

```sh
sudo yum install python-pip python-devel gcc
sudo pip install --upgrade ansible
```


## Installation

Please make sure you have fulfilled the aforementioned Dependencies
first!

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
    sh ~/.dotfiles/packages/nodejs-install.sh # requires git
    sh ~/.dotfiles/packages/vim-install.sh # requires git
    ```


## Updating

1. update the .dotfiles working copy

    ```sh
    cd ~/.dotfiles
    git pull
    ```

2. Just run the ansible playbooks (install step 3) again.

3. run `sh ~/.dotfiles/scripts/update.sh`


## Note: sudo

`sudo` usage is avoided where it can be. Currently, it is used for:

- installing `zsh` and `vim`
- ensuring installed `zsh` is in the `/etc/shells` file
- setting `zsh` as the default shell for the current user
- installing build dependencies for `ruby`
