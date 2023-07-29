#!/bin/sh

zsh_entry_point="zprofile"
bash_entry_point="bash_profile"
zsh_prompt="zsh_prompt"
bash_prompt="bash_prompt"

function colour_echo() {
    COLOUR='\033[0;35m'
    ENDCOLOUR='\033[0m'
    if [[ "$entry_point" == "zprofile" ]]; then
        echo -e "${COLOUR}$1${ENDCOLOUR}"
    else
        echo "$1"
    fi
}

function shell_config_setup() {
    colour_echo "Backing up shell config"
    if [ -s ~/.$zsh_entry_point ]; then
        mv ~/.$zsh_entry_point ~/.dotfiles/archive/ &>/dev/null
    fi
    if [ -s ~/.$bash_entry_point ]; then
        mv ~/.$bash_entry_point ~/.dotfiles/archive/ &>/dev/null
    fi
    if [ -s ~/.$zsh_prompt ]; then
        mv ~/.$zsh_prompt ~/.dotfiles/archive/ &>/dev/null
    fi
    if [ -s ~/.$bash_prompt ]; then
        mv ~/.$bash_prompt ~/.dotfiles/archive/ &>/dev/null
    fi

    colour_echo "Configuring shell profile"
    ln -s ~/.dotfiles/shell/$zsh_prompt ~/.$zsh_prompt &>/dev/null
    ln -s ~/.dotfiles/shell/$bash_prompt ~/.$bash_prompt &>/dev/null
    ln -s ~/.dotfiles/shell/all_profile ~/.$zsh_entry_point &>/dev/null
    ln -s ~/.dotfiles/shell/all_profile ~/.$bash_entry_point &>/dev/null
    if [[ $SHELL == "/bin/zsh" ]]; then
        ln -s ~/.dotfiles/shell/zsh_extras ~/.zsh_extras &>/dev/null
    fi
}

function create_custom_aliases() {
    colour_echo "Creating Custom Aliases file"
    custom_aliases=".custom_aliases"
    if [ -s ~/$custom_aliases ]; then
        touch ~/$custom_aliases
    fi
}

function brew_setup() {
    type brew &>/dev/null
    if [ $? -ne 0 ]; then
        colour_echo "Installing Brew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
        colour_echo "Finished installing Brew, installing Brew packages"
        brew bundle --file ~/.dotfiles/brew/Brewfile
    else
        colour_echo "Skipping Brew, looks like it's already installed,
        installing packages now"
    fi
}

function git_setup() {
    colour_echo "Configuring Git"
    if [ -s ~/.gitconfig ]; then
        mv ~/.gitconfig ~/.dotfiles/archive/ &>/dev/null
    fi
    ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
}

function work_git_setup() {
    colour_echo "Copying gitconfig-extended into work folder"
    mkdir -p ~/work/
    if [ -s ~/work/.gitconfig-work ]; then
        mv ~/work/.gitconfig-work ~/.dotfiles/archive/ &>/dev/null
    fi
    cp ~/.dotfiles/git/gitconfig-extended ~/work/.gitconfig-work
}

function personal_git_setup() {
    colour_echo "Configuring personal gitconfig"
    mkdir -p ~/personal/
    if [ -s ~/personal/.gitconfig-personal ]; then
        mv ~/personal/.gitconfig-personal ~/.dotfiles/archive/ &>/dev/null
    fi
    ln -s ~/.dotfiles/git/gitconfig-extended ~/personal/.gitconfig-personal

    if [ ! -s ~/personal/dotfiles ]; then
        ln -s ~/.dotfiles ~/personal/dotfiles
    fi
}

function vim_setup() {
    colour_echo "Configuring Vim"
    if [ -s ~/.vimrc ]; then
        mv ~/.vimrc ~/.dotfiles/archive/ &>/dev/null
    fi
    ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
}

function vscode_setup() {
    colour_echo "Configuring VS Code"
    if [ -s ~/Library/Application\ Support/Code/User/settings.json ]; then
        mv ~/Library/Application\ Support/Code/User/settings.json ~/.dotfiles/archive/ &>/dev/null
    fi
    ln -s ~/.dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

    colour_echo "Installing VS Code extensions"
    . ~/.dotfiles/vscode/extensions
}

# Create ssh and gpg foldets
function gpg_ssh_setup() {
    colour_echo "Prepping GPG and SSH folders"
    mkdir -p ~/.ssh
    gpg --list-secret-keys --keyid-format LONG
    mkdir -p ~/.gnupg
}

colour_echo "Setting up dotfiles..."
shell_config_setup
if [[ $SHELL == "/bin/zsh" ]]; then
    brew_setup
fi
git_setup
personal_git_setup
vim_setup
if [[ $SHELL == "/bin/zsh" ]]; then
    vscode_setup
fi
gpg_ssh_setup
colour_echo "Setup Complete!"

if [[ "$1" == "custom" ]]; then
    create_custom_aliases
    work_git_setup
fi
