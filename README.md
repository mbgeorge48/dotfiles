# dotfiles

_Haven't really tested this in WSL and the setup script won't work in regular Windows. So it might be worth manually copying them into place_

## Setup

1. Install Apple's Command Line Tools, which are prerequisites for Git and Homebrew.

```sh
xcode-select --install
```

2. Clone repo into new hidden directory.

```sh
# Use SSH (if set up)...
git clone git@github.com:mbgeorge48/dotfiles.git ~/.dotfiles

# ...or use HTTPS and switch remotes later.
git clone https://github.com/mbgeorge48/dotfiles.git ~/.dotfiles
```

3. Run the setup script which will do most of the setting up for you

```sh
bash ~/.dotfiles/setup.sh
```

If you're setting up a work machine you can add `work` as an arg in the `setup.sh` script, like so `bash ~/.dotfiles/setup.sh work`

## Specifics

For things not included in `setup.sh`

### GPG and SSH keys for GitHub

[Follow this guide to setup your GPG key](https://docs.github.com/en/authentication/managing-commit-signature-verification/adding-a-gpg-key-to-your-github-account)

#### GPG keys

Once you have the keys on your machine simply run

```bash
gpg --import public.key
gpg --import private.key
```

After Brew installs Pinentry run `which pinentry-mac` to get the path
Then add that path to `~/.gnupg/gpg-agent.conf`
Restart `gpgconf --kill gpg-agent`

If the GPG key is throwning an error you can run this to help debug it

```sh
echo "test" | gpg --clearsign
```

#### SSH keys

If you're reusing a key...

```sh
vim ~/.ssh/id_ed25519
<copy in your private key>
write and quit
chmod 600 ~/.ssh/id_ed25519
```

[Follow this guide to setup you SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

Test your ssh connection to GitHub with

```sh
ssh -T git@github.com
```

### Change Remote from HTTPs to SSH

`git remote set-url origin git@github.com:mbgeorge48/dotfiles.git`

### Games

_Bit of a random one but last time I reinstalled the game I lost it all so wanted to keep a backed up copy_

#### CSGO

The autoexec lives `..\Steam\steamapps\common\Counter-Strike Global Offensive\csgo\cfg`

The launch options I'm using are `-refresh 144 -tickrate 128 +fps_max 0 -novid -nojoy nosteamcontroller -fullscreen +exec autoexec.cfg`

#### TF2

The autoexec lives `..\Steam\steamapps\common\Team Fortress 2\tf\cfg`

The launch options I'm using are `-freq 144 -precachefontchars -novid -nojoy nosteamcontroller -fullscreen +exec autoexec.cfg`

## TODOs

Debain guide to setting up Pyenv and Node
PS1 being a bit flaky on bash
gpg caching in debian
Update ssh steps
