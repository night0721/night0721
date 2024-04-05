# Night Dotfiles

Catppuccin themed dotfiles for Alpine Linux

# Specifications
- OS: Alpine Linux
- WM: dwl
- Notifications: mako
- Terminal: foot
- Shell: sh
- AUR Helper: aureate
- Wallpaper daemon: wbg
- Wallpapers: [catppuccin](https://github.com/iQuickDev/catppuccin-wallpapers)
- File Manager: lf, ccc
- Search menu: fnf, wmenu
- Browser: firefox
- Font: Monaspice Kr Nerd Font
- Bootloader: grub

# Details

1. Grub theme: `.data/grub/n` (Based on [sayonara](https://github.com/samoht9277/dotfiles/tree/master/grub/themes/sayonara))

2. Login: SDDM(Remvoed, logging in with tty)
- Theme: [aerial](https://github.com/3ximus/aerial-sddm-theme)
- Packages: gst-libav phonon-qt5-gstreamer gst-plugins-good qt5-quickcontrols qt5-graphicaleffects qt5-multimedia

3. Shell: zsh (Removed, using sh)
- Theme: `.config/deprecated/zsh/n.zsh-theme`
- Plugins: zsh-autosuggestions, zsh-history-substring-search, zsh-syntax-highlighting

4. File Manager: lf
- Using [lfimg-sixel](https://github.com/Anima-OS-Dev/lfimg-sixel) to support sixel in lf with foot
- graphicsmagick for SVG and GIF preview
- [Fontpreview](https://github.com/sdushantha/fontpreview) for OTF TTF WOFF preview
- Required packages: imagemagick chafa ydotool fzf

5. GTK Theme: [Catppuccin](https://github.com/ljmill/catppuccin-icons)
Alternatively, you can use [papirus icons](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) with [this Catpuccin icon theme](https://aur.archlinux.org/packages/papirus-folders-catppuccin-git)

6. VM
- Packages: bridge-utils libvirt qemu-full virt-manager virt-viewer  

## Additional Information

You might need to install `grub-customizer` to remove other boot options, if syntax error occured, most likely a `:` will solve the problem

### Dual booting
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
git clone --bare git@codeberg.org:night0721/dotfiles
# OR
git init --bare $HOME/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
```
Credits to [this tutorial](https://www.atlassian.com/git/tutorials/dotfiles)

## Post setup
```
connmanctl scan wifi
connmanctl services
connmanctl connect wifi_...........
sudo pacman -Syu
```

### Firefox

Go to about:profiles and create a new profile with custom folder  
cd into the folder and create user.js  
Copy [betterfox](https://raw.githubusercontent.com/yokoffing/Betterfox/main/user.js) into user.js   
Restart firefox  
Then follow https://github.com/catppuccin/userstyles/ to install stylus  
Downloading [codeberg](https://github.com/catppuccin/userstyles/tree/main/styles/codeberg) and [github](https://github.com/catppuccin/userstyles/tree/main/styles/github) css themes selecting mocha and lavender.  

## Default Keybinds

SUPER + S = Start Terminal  
SUPER + F = Start Firefox  
SUPER + C = Kill Active Window  
SUPER + L = Lock Screen  
SUPER + M = Power menu  
SUPER + [1-9] = Switch to tags  
SUPER + SHIFT + [1-9] = Move active window to tag  
SUPER + SHIFT + Q = Quit to tty  
SUPER + O = Increase opacity  
SUPER + SHIFT + O = Decrease opacity  
SUPER + B = Toggle bar  
SUPER + AD = Switch focus to window  
SUPER + QE = Change window size  
SUPER + [,.] = Focus next/previous monitor
SUPER + SHIFT + [,.] = Move window to next/previous monitor
SUPER + SHIFT + SPACE = Toggle floating  
SUPER + ENTER = Toggle focus  
SUPER + P = Password menu  
SUPER + SPACE = App Launcher  
SUPER + SHIFT + S = Screenshot menu  
