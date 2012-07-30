## dotfiles

### Dependencies

1. install **zsh**
- in OS X:
    brew install zsh
- in Fedora Linux:
    yum install zsh
1. install **oh-my-zsh**, as per https://github.com/robbyrussell/oh-my-zsh

### Installation

Please make sure you have fulfilled the aforementioned Dependencies
first!

1. change to your home directory
    cd ~
1. clone this repository into a hidden directory
    git clone git@github.com:jokeyrhyme/dotfiles.git .dotfiles
1. remove any conflicting dot files
    rm .zshrc
1. create symbolic links
    ln .dotfiles/zshrc .zshrc

