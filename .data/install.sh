#!/bin/bash
efipart=/dev/nvme0n1p1
windowspart=/dev/nvme0n1p3

echo "Enter night password"
read nightpasswd

# clear the screen
clear

cd /home/night
# yay AUR helper
git clone https://aur.archlinux.org/yay.git > /dev/null
cd yay
makepkg -si --noconfirm > /dev/null
if [ -f /sbin/yay ]; then
    cd ..    
    # update the yay database
    yay -Syu --noconfirm > /dev/null
else
    # if this is hit then a package is missing, exit to review log
    exit
fi

### Install all of the above pacakges ####
yay -S --needed adobe-source-han-sans-hk-fonts adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts \
    bat blueman bluez bluez-utils btop catppuccin-gtk-theme-mocha cliphist figlet \
    firefox fzf graphicsmagick grub-customizer grim gst-libav gst-plugins-good gtk3 gvfs \
    hyprland-nvidia jq kitty lf libva libva-nvidia-driver-git linux-headers mako man-db mpv \
    ncdu neofetch neovim network-manager-applet newsboat nginx node noto-fonts-emoji npm nvidia-dkms \
    nvidia-settings nwg-look-bin pacman-contrib pamixer pavucontrol pdftricks pipewire \
    phonon-qt5-gstreamer plymouth python-requests qt5-graphicaleffects qt5-multimedia \
    qt5-quickcontrols qt5-quickcontrols2 qt5-svg qt5-wayland qt5ct qt6ct qt6-wayland sddm-git \
    slurp swappy swaylock-effects swww sxiv tmux tree ttf-jetbrains-mono-nerd unzip waybar wf-recorder wget wireplumber \
    wl-clipboard wofi xdg-desktop-portal-hyprland yt-dlp zip zsh --noconfirm > /dev/null
# update config
sudo sed -i 's/MODULES=()/MODULES=(amdgpu nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
sudo sed -i '/^HOOKS=/ s/udev/& plymouth/' /etc/mkinitcpio.conf
sudo mkinitcpio -p linux --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
echo -e "options nvidia-drm modeset=1" | sudo tee -a /etc/modprobe.d/nvidia.conf

if yay -Q hyprland &>> /dev/null ; then
    yay -R hyprland --noconfirm > /dev/null
fi

sudo systemctl enable --now bluetooth
sleep 2
sudo systemctl enable sddm
sleep 2 
# Clean out other portals
yay -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk > /dev/null

### Disable wifi powersave mode ###
LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
sudo mkdir -p /etc/NetworkManager/conf.d
sudo touch $LOC
echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC

### Copy Config Files ###
cp -R /dotfiles/.config /home/night
mkdir /home/night/.local/bin
cp -R /dotfiles/.local/bin /home/night/.local

# Copy the SDDM theme
cd /dotfiles
sudo git clone https://github.com/3ximus/aerial-sddm-theme aerial
sudo cp -R aerial /usr/share/sddm/themes/
sudo chown -R $USER:$USER /usr/share/sddm/themes/aerial
cd /usr/share/sddm/themes/aerial
rm -rf playlists screens .git README.md LICENSE .gitignore theme.conf.user background.jpg
cp /dotfiles/.data/aerial/night.m3u /dotfiles/.data/aerial/theme.conf.user /dotfiles/.config/background.png .
sudo mkdir /etc/sddm.conf.d
sudo touch /etc/sddm.conf.d/10-theme.conf
echo -e "[Theme]\nCurrent=aerial" | sudo tee -a /etc/sddm.conf.d/10-theme.conf

# autojump
cd /home/night
git clone git://github.com/wting/autojump.git
cd autojump
./install.py

# stage the .desktop file
sudo mkdir /usr/share/wayland-sessions  
sudo cp /dotfiles/.data/misc/hyprland.desktop /usr/share/wayland-sessions/

# setup the first look and feel as dark
xfconf-query -c xsettings -p /Net/IconThemeName -s "Catppuccin-SE"
gsettings set org.gnome.desktop.interface icon-theme "Catppuccin-SE"
xfconf-query -c xsettings -p /Net/ThemeName -s "Catppuccin-Mocha-Standard-Lavender-Dark"
gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Mocha-Standard-Lavender-Dark"

# zsh
ln -sf /home/night/.config/zsh/.zshenv /home/night/.zshenv
# cd /home/.config/zsh
# git clone https://github.com/zsh-users/zsh-autosuggestions
#git clone https://github.com/zsh-users/zsh-syntax-highlighting

# plymouth
cd /usr/share/plymouth/themes/
sudo git clone https://github.com/farsil/monoarch > /dev/null
sudo plymouth-set-default-theme -R monoarch > /dev/null

# grub
sudo mount --mkdir $efipart /boot/efi/
sudo mount --mkdir $windowspart /run/media/N
cd /dotfiles
sudo mv /etc/default/grub /etc/default/grub.bak # use this in case grub breaks
sudo cp .data/misc/grub /etc/default/grub
suso mkdir -p /boot/grub/themes/
sudo cp -r .data/misc/sayonara /boot/grub/themes/sayonara
sudo grub-install —-target=x86_64-efi --efi-directory=/boot/efi —-bootloader-id=Arch —-recheck
sudo grub-mkconfig -o /boot/grub/grub.cfg

# remove pacman stuff
sudo pacman -Rns $(pacman -Qdttq) --noconfirm > /dev/null # remove orphans
pacman -Qqd | pacman -Rsu - > /dev/null
sudo paccache -dvuk1 > /dev/null

# npm
npm config set prefix '~/.local/npm'

cd /home/night
curl -L -O https://github.com/ljmill/catppuccin-icons/releases/download/v0.2.0/Catppuccin-SE.tar.bz2
sudo tar -xf Catppuccin-SE.tar.bz2 -C /usr/share/icons

printf "$nightpasswd\n" | chsh -s /usr/bin/zsh

sudo systemctl enable --now NetworkManager
echo "Install finished, type 'reboot'"
