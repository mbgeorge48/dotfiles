# dotfiles

_Haven't really tested this in WSL and the setup script won't work in regular Windows. So it might be worth manually copying them into place_

## Setup

1. Install Apple's Command Line Tools, which are prerequisites for Git and Homebrew.

```zsh
xcode-select --install
```

2. Clone repo into new hidden directory.

```zsh
# Use SSH (if set up)...
git clone git@github.com:mbgeorge48/dotfiles.git ~/.dotfiles

# ...or use HTTPS and switch remotes later.
git clone https://github.com/mbgeorge48/dotfiles.git ~/.dotfiles
```

4. Install Homebrew, followed by the software listed in the Brewfile.

```zsh
# These could also be in an install script.

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Then pass in the Brewfile location...
brew bundle --file ~/.dotfiles/brew/Brewfile
```

4. You can manually create symlinks in the Home directory to the real files in the repo. e.g.

```zsh
ln -s ~/.dotfiles/shell/zsh_aliases ~/.zsh_aliases
ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
```

Or you can run the setup script which will move existing files into an archive directory and create the symlinks in their place.

```zsh
bash ~/.dotfiles/setup.sh
```

If you're setting up a work machine you can add `work` as an arg in the `setup.sh` script, like so `bash ~/.dotfiles/setup.sh work`

## Specifics

For things not included in `setup.sh`

### GPG and SSH keys for GitHub

[Follow this guide to setup your GPG key](https://docs.github.com/en/authentication/managing-commit-signature-verification/adding-a-gpg-key-to-your-github-account)

[Follow this guide to setup you SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

### Games

_Bit of a random one but last time I reinstalled the game I lost it all so wanted to keep a backed up copy_

#### CSGO

The autoexec lives `..\Steam\steamapps\common\Counter-Strike Global Offensive\csgo\cfg`

The launch options I'm using are `-refresh 144 -tickrate 128 +fps_max 0 -novid -nojoy nosteamcontroller -fullscreen +exec autoexec.cfg`

#### TF2

The autoexec lives `..\Steam\steamapps\common\Team Fortress 2\tf\cfg`

The launch options I'm using are `-freq 144 -precachefontchars -novid -nojoy nosteamcontroller -fullscreen +exec autoexec.cfg`

## TODOs
