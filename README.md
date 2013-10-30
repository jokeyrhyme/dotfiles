## dotfiles

### Dependencies

You will need to have a the gcc toolchain installed (for building Ruby).

You will need to have ansible installed (which requires Python 2).

### Installation

Please make sure you have fulfilled the aforementioned Dependencies
first!

1. clone this repository into a hidden directory

    ```
    git clone https://github.com/jokeyrhyme/dotfiles.git ~/.dotfiles
    ```

2. run the ansible playbooks

    ```
    ansible-playbook -c local -i ~/.dotfiles/playbooks/localhost ~/.dotfiles/playbooks/general.yml
    ```

### Updating

1. update the .dotfiles working copy

    ```
    cd ~/.dotfiles
    git pull
    ```

2. Just run the ansible playbooks (install step 3) again.

