#!/bin/sh

COLOUR='\033[0;35m'
ENDCOLOUR='\033[0m'

echo "${COLOUR}Setting up dotfiles...${ENDCOLOUR}"

echo "${COLOUR}Configuring shell aliases${ENDCOLOUR}"
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

echo "${COLOUR}Configuring shell profile${ENDCOLOUR}"
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

ln -s ~/.dotfiles/shell/all_profile ~/.$profile &> /dev/null
ln -s ~/.dotfiles/shell/$aliases ~/.$aliases &> /dev/null

if ! grep -q "source ~/.$profile" ~/.$rcfile; then
    echo "source ~/.$profile\n" >> ~/.$rcfile
fi

if ! grep -q "source ~/.$aliases" ~/.$rcfile; then
    echo  "source ~/.$aliases\n" >> ~/.$rcfile
fi

if [[ "$1" == "work" ]]; then
    filename=".work_aliases"
    if [ -s ~/$filename ]; then
        touch ~/$filename
    fi
    if ! grep -q "source ~/$filename" ~/.$rcfile; then
        echo  "source ~/$filename\n" >> ~/.$rcfile
    fi
fi


type brew &> /dev/null
if [ $? -ne 0 ]; then
    echo "${COLOUR}Installing Brew${ENDCOLOUR}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if ! grep -q "# Set PATH, MANPATH, etc., for Homebrew." ~/.$profile; then
        echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.$profile
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.$profile
    fi
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo "${COLOUR}Finished installing Brew, installing Brew packages${ENDCOLOUR}"
    brew bundle --file ~/.dotfiles/brew/Brewfile
else
    echo "${COLOUR}Skipping Brew, looks like it's already installed${ENDCOLOUR}"
fi


echo "${COLOUR}Configuring Git${ENDCOLOUR}"
if [ -s ~/.gitconfig ]; then
    mv ~/.gitconfig ~/.dotfiles/archive/ &> /dev/null
fi
ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig

if [[ "$1" == "work" ]]; then
    echo "${COLOUR}Copying gitconfig-extended into work folder${ENDCOLOUR}"
    mkdir -p ~/work/
    if [ -s ~/work/.gitconfig-work ]; then
        mv ~/work/.gitconfig-work ~/.dotfiles/archive/ &> /dev/null
    fi
    cp ~/.dotfiles/git/gitconfig-extended ~/work/.gitconfig-work
fi

echo "${COLOUR}Configuring personal gitconfig${ENDCOLOUR}"
mkdir -p ~/personal/
if [ -s ~/personal/.gitconfig-personal ]; then
    mv ~/personal/.gitconfig-personal ~/.dotfiles/archive/ &> /dev/null
fi
ln -s ~/.dotfiles/git/gitconfig-extended ~/personal/.gitconfig-personal
ln -s ~/.dotfiles ~/personal/dotfiles


echo "${COLOUR}Configuring Vim${ENDCOLOUR}"
if [ -s ~/.vimrc ]; then
    mv ~/.vimrc ~/.dotfiles/archive/ &> /dev/null
fi
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc


echo "${COLOUR}Configuring VS Code${ENDCOLOUR}"
if [ -s ~/Library/Application\ Support/Code/User/settings.json ]; then
    mv ~/Library/Application\ Support/Code/User/settings.json ~/.dotfiles/archive/ &> /dev/null
fi
ln -s ~/.dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

echo "${COLOUR}Installing VS Code extensions${ENDCOLOUR}"
source ~/.dotfiles/vscode/extensions

# Create ssh and gpg foldets

echo "${COLOUR}Prepping GPG and SSH folders${ENDCOLOUR}"
mkdir -p ~/.ssh
gpg --list-secret-keys --keyid-format LONGmkdir -p ~/.gpug