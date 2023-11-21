# My Arch Linux Setup

## Specifications

## Bootloader - Grub
Using my theme, based on [sayonara theme](https://github.com/samoht9277/dotfiles/tree/master/grub/themes/sayonara)

## WM - Hyprland
*Based on [HyprV4](https://github.com/SolDoesTech/HyprV4)*

# DM - SDDM (Removed)
Using [aerial](https://github.com/3ximus/aerial-sddm-theme)
Required packages: gst-libav phonon-qt5-gstreamer gst-plugins-good qt5-quickcontrols qt5-graphicaleffects qt5-multimedia

# Shell - zsh
Using [powerlevel10k](https://github.com/romkatv/powerlevel10k) for theme, zsh-autosuggestions for auto complete and zsh-history-substring-search for finding previously used commands, zsh-syntax-highlighting for showing syntax errors

# File Manager - lf
Using [lf-gadgets](https://github.com/slavistan/lf-gadgets) with lf-kitty to provide image preview support in lf
Using [lfimg-sixel](https://github.com/Anima-OS-Dev/lfimg-sixel) to support sixel in lf with foot
pdftricks - PDF preview
graphicsmagick - SVG and GIF preview
Required packages: pdftricks grpahicsmagick chafa

[Fontpreview](https://github.com/sdushantha/fontpreview) - To preview .otf, .ttf, .woff files in lf
Required pacakges: xdotool fzf imagemagick sxiv

## Additional Information

You might need to install `grub-customizer` to remove other kernel options, if syntax error occured, most likely a `:` will solve the problem

GTK Icon Theme: https://github.com/ljmill/catppuccin-icons
You may use [papirus icons](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) with [this Catpuccin icon theme](https://aur.archlinux.org/packages/papirus-folders-catppuccin-git) as an alternative.

For firefox, you can set font to Nerd fonts to show some special symbols in case there is some.

tldr can be installed using npm
```bash
npm i -g tldr
```
Windws partition in fstab should have these properties
```
UUID=94ACAFD1ACAFAC64   /run/media/N    ntfs        rw,user,auto,fmask=133,dmask=022,uid=1000,gid=1000  0 0
```

## Install

```
iwctl
device list # find device name
station [device name] connect [network name]
exit
pacman -Sy git
git clone https://github.com/night0721/dotfiles
bash dotfiles/.data/root.sh
```

## Setup

```
git init --bare $HOME/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
```
Credits to [this tutorial](https://www.atlassian.com/git/tutorials/dotfiles)

## Post setup

```
nmcli device wifi connect [network name] password [password]
yay
nwg-look
grub-customizer
rmmod pcspkr
rmmod snd_pcsp
```
### Firefox

Go to about:profiles and create a new profile with custom folder

cd into the folder and create user.js

Copy [betterfox](https://raw.githubusercontent.com/yokoffing/Betterfox/main/user.js) into user.js

Restart firefox

Then follow https://github.com/catppuccin/userstyles/ to install stylus

Downloading [codeberg](https://github.com/catppuccin/userstyles/tree/main/styles/codeberg) and [github](https://github.com/catppuccin/userstyles/tree/main/styles/github) css themes selecting mocha and lavender.

## Default Keybinds

SUPER + S = Start Kitty

SUPER + F = Start Firefox

SUPER + E = File Manager

SUPER + C = Kill Active Window

SUPER + L = Lock Screen

SUPER + M = Logout menu

SUPER + N = Refresh waybar

SUPER + V = Toggle Float

SUPER + J = Toggle Split

SUPER + SPACE = App Launcher

SUPER + SHIFT + S = Screenshot
