#!/bin/sh

case $SHELL in
    '/bin/zsh')
        profile="zprofile"
        aliases="zsh_aliases"
        rcfile="zshrc"
    ;;
    '/bin/bash')
        profile="bash_profile"
        aliases="bash_aliases"
        rcfile="bashrc"
    ;;
esac

function colour_echo () {
    COLOUR='\033[0;35m'
    ENDCOLOUR='\033[0m'
    if [[ "$rcfile" == "zshrc" ]]; then
        echo "${COLOUR}$1${ENDCOLOUR}"
    else
        echo "$1"
    fi
}

function shell_config_setup () {
    colour_echo "Backing up shell config"
    if [ -s ~/.bash_profile ]; then
        mv ~/.bash_profile ~/.dotfiles/archive/ &> /dev/null
    fi
    if [ -s ~/.bash_aliases ]; then
        mv ~/.bash_aliases ~/.dotfiles/archive/ &> /dev/null
    fi

    if [ -s ~/.zprofile ]; then
        mv ~/.zprofile ~/.dotfiles/archive/ &> /dev/null
    fi
    if [ -s ~/.zsh_aliases ]; then
        mv ~/.zsh_aliases ~/.dotfiles/archive/ &> /dev/null
    fi

    colour_echo "Configuring shell profile"
    ln -s ~/.dotfiles/shell/all_profile ~/.$profile &> /dev/null
    ln -s ~/.dotfiles/shell/$aliases ~/.$aliases &> /dev/null

    if ! grep -q "source ~/.$profile" ~/.$rcfile; then
        echo "" >> ~/.$rcfile
        echo "source ~/.$profile" >> ~/.$rcfile
    fi

    if ! grep -q "source ~/.$aliases" ~/.$rcfile; then
        echo "" >> ~/.$rcfile
        echo  "source ~/.$aliases" >> ~/.$rcfile
    fi
}

function create_work_aliases () {
    colour_echo "Creating Work Aliases file"
    filename=".work_aliases"
    if [ -s ~/$filename ]; then
        touch ~/$filename
    fi
    if ! grep -q "source ~/$filename" ~/.$rcfile; then
        echo "" >> ~/.$rcfile
        echo  "source ~/$filename" >> ~/.$rcfile
    fi
}

function brew_setup () {
    type brew &> /dev/null
    if [ $? -ne 0 ]; then
        colour_echo "Installing Brew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        if ! grep -q "# Set PATH, MANPATH, etc., for Homebrew." ~/.$profile; then
            echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.$profile
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.$profile
        fi
        eval "$(/opt/homebrew/bin/brew shellenv)"
        colour_echo "Finished installing Brew, installing Brew packages"
        brew bundle --file ~/.dotfiles/brew/Brewfile
    else
        colour_echo "Skipping Brew, looks like it's already installed"
    fi
}

function git_setup () {
    colour_echo "Configuring Git"
    if [ -s ~/.gitconfig ]; then
        mv ~/.gitconfig ~/.dotfiles/archive/ &> /dev/null
    fi
    ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
}

function work_git_setup () {
    colour_echo "Copying gitconfig-extended into work folder"
    mkdir -p ~/work/
    if [ -s ~/work/.gitconfig-work ]; then
        mv ~/work/.gitconfig-work ~/.dotfiles/archive/ &> /dev/null
    fi
    cp ~/.dotfiles/git/gitconfig-extended ~/work/.gitconfig-work
}

function personal_git_setup () {
    colour_echo "Configuring personal gitconfig"
    mkdir -p ~/personal/
    if [ -s ~/personal/.gitconfig-personal ]; then
        mv ~/personal/.gitconfig-personal ~/.dotfiles/archive/ &> /dev/null
    fi
    ln -s ~/.dotfiles/git/gitconfig-extended ~/personal/.gitconfig-personal
    ln -s ~/.dotfiles ~/personal/dotfiles
}

function vim_setup () {
    colour_echo "Configuring Vim"
    if [ -s ~/.vimrc ]; then
        mv ~/.vimrc ~/.dotfiles/archive/ &> /dev/null
    fi
    ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
}

function vscode_setup () {
    colour_echo "Configuring VS Code"
    if [ -s ~/Library/Application\ Support/Code/User/settings.json ]; then
        mv ~/Library/Application\ Support/Code/User/settings.json ~/.dotfiles/archive/ &> /dev/null
    fi
    ln -s ~/.dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

    colour_echo "Installing VS Code extensions"
    source ~/.dotfiles/vscode/extensions
}

# Create ssh and gpg foldets
function gpg_ssh_setup () {
    colour_echo "Prepping GPG and SSH folders"
    mkdir -p ~/.ssh
    gpg --list-secret-keys --keyid-format LONG
    mkdir -p ~/.gnupg
}

colour_echo "Setting up dotfiles..."
shell_config_setup
#brew_setup
git_setup
personal_git_setup
vim_setup
#vscode_setup
gpg_ssh_setup
colour_echo "Setup Complete!"

if [[ "$1" == "work" ]]; then
    create_work_aliases
    work_git_setup
fi
