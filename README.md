### To install zshrc from this repo

    git clone https://github.com/mark-duggan/dotfiles ~/.dotfiles

### Install required OS packages

    sudo apt install zsh stow fzf direnv

### Link .zshrc from repo

    cd ~/.dotfiles
    stow zsh

### Change shell for current user

    sudo chsh -s /usr/bin/zsh $USER
