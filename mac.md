# Mac specific stuff

_Careful running these commands... I've tried them on my machine and they work, I'll also write what each one of them does._

## Dock

You can run `defaults read com.apple.dock` to get the default values.
You should take a copy of the output so you can reset it if you need (although you can do that in the UI for most of them).

```bash
defaults read com.apple.dock > ~/.dotfiles/archive/dock-defaults.txt
```

---

Position the Dock to the left

```bash
defaults write com.apple.dock orientation left
```

---

Minimise windows using the scale effect

```bash
defaults write com.apple.dock mineffect -string scale
```

---

Make the Dock auto hide

```bash
defaults write com.apple.dock autohide -bool true
```

---

Make the Dock icons size 40 (Don't go higher than 128)

```bash
defaults write com.apple.dock tilesize -int 40
```

---

Enable Magnification

```bash
defaults write com.apple.dock magnification -bool true
```

---

Make the Dock icons magnify to size 48 (Don't go higher than 512)

```bash
defaults write com.apple.dock largesize -int 48
```

---

Make the dock appear and disappear instantly

```bash
defaults write com.apple.dock autohide-delay -float 0
```

```bash
defaults write com.apple.dock autohide-time-modifier -int 0
```

---

Restart the Dock so the changes take effect

```bash
killall Dock
```

## Finder

You can run `defaults read com.apple.finder` to get the default values.
You should take a copy of the output so you can reset it if you need (although you can do that in the UI for most of them).

```bash
defaults read com.apple.finder > ~/.dotfiles/archive/finder-defaults.txt
```

---

Show hidden files

```bash
defaults write com.apple.finder AppleShowAllFiles -bool false
```

---

Hide the tags from the side bar

```bash
defaults write com.apple.finder ShowRecentTags -bool false
```

---

Set the default file path when finder opens to the logged in users home directory

```bash
defaults write com.apple.finder NewWindowTargetPath file:///Users/`whoami`/
```

---

Show the status bar in the finder

```bash
defaults write com.apple.finder ShowStatusBar -bool true
```

---

Show the path bar in the finder

```bash
defaults write com.apple.finder ShowPathbar -bool true
```

---

Show the side bar in the finder

```bash
defaults write com.apple.finder ShowSidebar -bool true
```

---

Don't show the removable media icon on the desktop

```bash
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
```

---

Show file extensions

```bash
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
```

---

Restart Finder so the changes take effect

```bash
killall finder
```

## Misc

Change the screenshot capture type from png to jpg (Saves a bunch of disk space)

```bash
defaults write com.apple.screencapture type jpg
```

---

Change the screenshot save location to `~/Pictures/screenshots`

```bash
mkdir ~/Pictures/screenshots
defaults write com.apple.screencapture location ~/Pictures/screenshots
```

---

Turn off the Mac autocorrect stuff

```bash
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
```

```bash
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
```

```bash
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false
```

---

Set the startup and default Terminal to Pro

```bash
defaults write com.apple.terminal "Startup Window Settings" "Pro"
```

```bash
defaults write com.apple.terminal "Default Window Settings" "Pro"
```

---

Turn off mouse natural scroll

```bash
defaults write -g com.apple.swipescrolldirection -int 0
```

---

Set the keyboard repeat rate and delay until repeat to the fastest/shortest settings _Not fully tested yet_

```bash
defaults write -g KeyRepeat -int 2
```

```bash
defaults write -g InitialKeyRepeat -int 15
```
