## dotfiles

### Dependencies

#### Z Shell

1. install **zsh**
  * in OS X:

    brew install zsh

  * in Fedora Linux:
    yum install zsh

1. install **oh-my-zsh**, as per https://github.com/robbyrussell/oh-my-zsh

#### VIM

1. install **vim**
  * in OS X:

    brew install macvim

  * in Fedora Linux:

    yum install gvim

1. install **janus**, as per https://github.com/carlhuda/janus

### Installation

Please make sure you have fulfilled the aforementioned Dependencies
first!

1. change to your home directory

    cd ~

1. clone this repository into a hidden directory

    git clone https://github.com/jokeyrhyme/dotfiles.git .dotfiles

1. remove any conflicting dot files

    rm .zshrc

1. create symbolic links

    ln -s .dotfiles/zshrc .zshrc
    ln -s .dotfiles/gvimrc.after .gvimrc.after
    ln -s .dotfiles/vimrc.after .vimrc.after
    ln -s .dotfiles/janus .janus

1. change to the dotfiles directory

    cd ~/.dotfiles

1. pull in git submodules

    git submodules init
    git submodules update

