## dotfiles

### Dependencies

#### Z Shell

1. install **zsh**

  * in OS X:

```
    brew install zsh
```

  * in Fedora Linux:

```
    yum install zsh
```

2. install **oh-my-zsh**, as per https://github.com/robbyrussell/oh-my-zsh

3. double-check that your PATH is set appropriately by `/etc/zprofile`, which you might find convenient (if not
already configured this way) to source `/etc/profile` or `/etc/profile.d` (or vice versa) to maintain easy
compatibility with **bash** users on the same system


#### VIM

1. install **vim**

  * in OS X:

```
    brew install macvim
```

* in Fedora Linux:

```
    yum install gvim
```

2. install **janus**, as per https://github.com/carlhuda/janus

### Installation

Please make sure you have fulfilled the aforementioned Dependencies
first!

1. change to your home directory

    ```
    cd ~
    ```

2. clone this repository into a hidden directory

    ```
    git clone https://github.com/jokeyrhyme/dotfiles.git .dotfiles
    ```

3. remove any conflicting dot files

    ```
    rm .zshrc
    ```

4. pull in git submodules

    ```
    cd ~/.dotfiles
    git submodule init
    git submodule update
    ```
    
5. configure symbolic links and directories

    ```
    ln -s ~/.dotfiles/zshrc ~/.zshrc
    
    ln -s ~/.dotfiles/gvimrc.after ~/.gvimrc.after
    ln -s ~/.dotfiles/vimrc.after ~/.vimrc.after
    ln -s ~/.dotfiles/janus ~/.janus
    ln -s ~/.dotfiles/nave ~/.nave
    
    ln -s ~/.dotfiles/rbenv ~/.rbenv
    mkdir -p ~/.rbenv/cache
    mkdir -p ~/.rbenv/plugins
    ln -s ~/.dotfiles/rbenv-plugins/ruby-build ~/.rbenv/plugins/ruby-build
    ```


### Update

1. update git repository and git submodules

    ```
    cd ~/.dotfiles
    git pull
    git submodule init
    git submodule update
    git submodule foreach --recursive git pull origin master
    ```
    
2. update janus

    ```
    cd ~/.vim
    rake
    ```