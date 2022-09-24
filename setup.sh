#!/bin/sh

echo "Setting up dotfiles..."

# Shell
if [ -s ~/.bash_aliases ]; then
    mv ~/.bash_aliases archive/
fi

if [ -s ~/.zsh_aliases ]; then
    mv ~/.zsh_aliases archive/
fi

case $SHELL in
    '/bin/zsh')
        ln -s ~/.dotfiles/shell/zsh_aliases ~/.zsh_aliases
        if ! grep -q "source ~/.zsh_aliases" ~/.zshrc; then
            echo -e "\nsource ~/.zsh_aliases\n" >> ~/.zshrc
        fi
    ;;
    '/bin/bash')
        ln -s ~/.dotfiles/shell/bash_aliases ~/.bash_aliases
        if ! grep -q "source ~/.bash_aliases" ~/.bashrc; then
            echo -e "\nsource ~/.bash_aliases\n" >> ~/.bashrc
        fi
    ;;
esac


# Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle --file ~/.dotfiles/brew/Brewfile


# Git
if [ -s ~/.gitconfig ]; then
    mv ~/.gitconfig archive/
fi
ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig


# Vim
if [ -s ~/.vimrc ]; then
    mv ~/.vimrc archive/
fi
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc


# Vscode
if [ -s ~/Library/Application Support/Code/User/settings.json ]; then
    mv ~/Library/Application Support/Code/User/settings.json archive/
fi
ln -s ~/.dotfiles/vscode/settings.json ~/Library/Application Support/Code/User/settings.json

source ~/.dotfiles/vscode/extensions