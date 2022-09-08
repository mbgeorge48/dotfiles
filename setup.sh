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
        ln -s ~/.dotfiles/shell/zsh_aliases ~/.gitconfig

        # create symlink
        # Add source bla bla to the zshrc file
    ;;

    '/bin/bash')
        # Same as above
    ;;
esac

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

# Node

# Python

# Vscode
