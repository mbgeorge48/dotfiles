#!/bin/sh

echo "Setting up dotfiles..."

echo "Configuring shell aliases"
if [ -s ~/.bash_aliases ]; then
    mv ~/.bash_aliases ~/.dotfiles/archive/
fi

if [ -s ~/.zsh_aliases ]; then
    mv ~/.zsh_aliases ~/.dotfiles/archive/
fi

echo "Configuring shell profile"
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


echo "Installing Brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "Installing Brew packages"
brew bundle --file ~/.dotfiles/brew/Brewfile


echo "Configuring Git"
if [ -s ~/.gitconfig ]; then
    mv ~/.gitconfig ~/.dotfiles/archive/
fi
ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig

if [[ "$1" == "work" ]]; then
    echo "Copying gitconfig-extended into work folder"
    mkdir ~/work/
    if [ -s ~/work/.gitconfig-work ]; then
        mv ~/work/.gitconfig-work ~/.dotfiles/archive/
    fi
    cp ~/.dotfiles/git/gitconfig-extended ~/work/.gitconfig-work
fi

echo "Configuring personal gitconfig"
mkdir ~/personal/
if [ -s ~/personal/.gitconfig-personal ]; then
    mv ~/personal/.gitconfig-personal ~/.dotfiles/archive/
fi
ln -s ~/.dotfiles/git/gitconfig-extended ~/personal/.gitconfig-personal


echo "Configuring Vim"
if [ -s ~/.vimrc ]; then
    mv ~/.vimrc ~/.dotfiles/archive/
fi
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc


echo "Configuring VS Code"
if [ -s ~/Library/Application Support/Code/User/settings.json ]; then
    mv ~/Library/Application Support/Code/User/settings.json ~/.dotfiles/archive/
fi
ln -s ~/.dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

echo "Installing VS Code extensions "
source ~/.dotfiles/vscode/extensions