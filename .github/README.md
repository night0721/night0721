# Night Dotfiles

Catppuccin themed dotfiles for Arch Linux

# Specifications
- OS: Arch Linux
- WM: dwl
- Topbar: dwl-bar
- Notifications: mako
- Terminal: foot
- Shell: zsh
- Wallpaper daemon: wbg
- Wallpapers: [catppuccin](https://github.com/iQuickDev/catppuccin-wallpapers)
- File Manager: lf
- Search menu: fzf, bemenu
- Browser: firefox
- Font: JetBrains Mono Nerd Font
- Bootloader: grub

# Details
*Note: Parts with hyprland and mako is made by SolDoesTech with their HyprV4*

1. Grub theme: `.data/grub/n` (Based on [sayonara](https://github.com/samoht9277/dotfiles/tree/master/grub/themes/sayonara))

2. Login: SDDM(Remvoed, logging in with tty)
- Theme: [aerial](https://github.com/3ximus/aerial-sddm-theme)
- Required packages: gst-libav phonon-qt5-gstreamer gst-plugins-good qt5-quickcontrols qt5-graphicaleffects qt5-multimedia

3. Shell: zsh
- Theme: `.config/zsh/n.zsh-theme`
- Plugins: zsh-autosuggestions, zsh-history-substring-search, zsh-syntax-highlighting

4. File Manager: lf
- Using [lfimg-sixel](https://github.com/Anima-OS-Dev/lfimg-sixel) to support sixel in lf with foot
- graphicsmagick for SVG and GIF preview
- [Fontpreview](https://github.com/sdushantha/fontpreview) for OTF TTF WOFF preview
- Required packages: grpahicsmagick chafa ydotool fzf imagemagick

5. GTK Theme: [Catppuccin](https://github.com/ljmill/catppuccin-icons)
Alternatively, you can use [papirus icons](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) with [this Catpuccin icon theme](https://aur.archlinux.org/packages/papirus-folders-catppuccin-git)
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
nmcli device wifi connect [network name] password [password]
yay
grub-customizer
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

# Packages

Fonts: adobe-source-han-sans-{hk,jp,kr}-fonts noto-fonts-emoji ttf-jetbrains-mono-nerd  
Shell softwares: bat btop chafa fzf lf mpv ncdu neovim newsboat pass ripgrep socat tmux tree unzip wget wf-recorder wl-clipboard wlr-randr ydotool yt-dlp zip zsh  
Development: npm python-{mutagen,pip}  
Browser: firefox  
Enviroment: gtk3 mako plymouth slurp swappy waybar xdg-desktop-portal-wlr wlroots-nvidia xorg-xhost zathura zathura-pdf-poppler  
Audio: pamixer pipewire pipewire-{alsa,jack,pulse} wireplumber  
Graphics: graphicsmagick  
Bluetooth: bluez bluez-{libs,utils}  
Suckless: bemenu foot  
VM: bridge-utils libvirt qemu-full virt-manager virt-viewer  
Utils: brillo grub-customizer grim libnotify man-db ntfs-3g pacman-contrib  
Drivers: libva nvidia-dkms   
Kernel: linux linux-headers  
