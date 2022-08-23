#!/bin/sh

echo "Setting up dotfiles..."

# Shell
if [ -s $HOME/.bash_aliases ]; then
    mv $HOME/.bash_aliases archive/
fi

if [ -s $HOME/.zsh_aliases ]; then
    mv $HOME/.zsh_aliases archive/
fi

# Brew

# Git
if [ -s $HOME/.gitconfig ]; then
    mv $HOME/.gitconfig archive/
fi

# Vim
if [ -s $HOME/.vimrc ]; then
    mv $HOME/.vimrc archive/
fi

# Vscode
