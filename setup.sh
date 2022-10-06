#!/bin/sh

echo "Setting up dotfiles..."

# Shell
if [ -s ~/.bash_aliases ]; then
    mv ~/.bash_aliases ~/.dotfiles/archive/
fi

if [ -s ~/.zsh_aliases ]; then
    mv ~/.zsh_aliases ~/.dotfiles/archive/
fi

case $SHELL in
    '/bin/zsh')
        ln -s ~/.dotfiles/shell/all_profile ~/.zprofile
        ln -s ~/.dotfiles/shell/zsh_aliases ~/.zsh_aliases
        if ! grep -q "source ~/.zsh_aliases" ~/.zshrc; then
            echo -e "source ~/.zsh_aliases\n" >> ~/.zshrc
        fi
    ;;
    '/bin/bash')
    ln -s ~/.dotfiles/shell/all_profile ~/.bash_profile
        if ! grep -q "source ~/.bash_profile" ~/.bashrc; then
            echo -e "source ~/.bash_profile\n" >> ~/.bashrc
        fi
        ln -s ~/.dotfiles/shell/bash_aliases ~/.bash_aliases
        if ! grep -q "source ~/.bash_aliases" ~/.bashrc; then
            echo -e "source ~/.bash_aliases\n" >> ~/.bashrc
        fi
    ;;
esac


# Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle --file ~/.dotfiles/brew/Brewfile


# Git
if [ -s ~/.gitconfig ]; then
    mv ~/.gitconfig ~/.dotfiles/archive/
fi
ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig


# Vim
if [ -s ~/.vimrc ]; then
    mv ~/.vimrc ~/.dotfiles/archive/
fi
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc


# Vscode
if [ -s ~/Library/Application Support/Code/User/settings.json ]; then
    mv ~/Library/Application Support/Code/User/settings.json ~/.dotfiles/archive/
fi
ln -s ~/.dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

source ~/.dotfiles/vscode/extensions