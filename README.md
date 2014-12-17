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

### Homebrew

For OS X systems, make sure you install [Homebrew](http://brew.sh/) before you
begin.


## Installation

Please make sure you have fulfilled the aforementioned Dependencies
first!

1. clone this repository into a hidden directory

    ```
    git clone https://github.com/jokeyrhyme/dotfiles.git ~/.dotfiles
    ```

2. run the ansible playbooks (it'll prompt for `sudo` passphrase)

    ```
    ansible-playbook -K -c local -i ~/.dotfiles/playbooks/localhost ~/.dotfiles/playbooks/general.yml
    ```

## Updating

1. update the .dotfiles working copy

    ```
    cd ~/.dotfiles
    git pull
    ```

2. Just run the ansible playbooks (install step 3) again.

## Note: sudo

`sudo` usage is avoided where it can be. Currently, it is used for:

- installing `zsh` and `vim`
- ensuring installed `zsh` is in the `/etc/shells` file
- setting `zsh` as the default shell for the current user
- installing build dependencies for `ruby`
