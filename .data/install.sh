#!/bin/bash

# clear the screen
clear

# find the Nvidia GPU
if lspci -k | grep -A 2 -E "(VGA|3D)" | grep -iq nvidia; then
    ISNVIDIA=true
else
    ISNVIDIA=false
fi

echo "Enter EFI Partition"
read efipart
echo "Enter Windows Partition"
read windowspart
mount -mkdir $efipart /boot/efi
mount -mkdir $windowspart /run/media/N
echo "# $windowspart\nUUID=94ACAFD1ACAFAC64\t\t\t\t/run/media/N\tntfs\t\trw,user,auto,fmask=133,dmask=022,uid=1000\t0 0" | sudo tee -a /etc/fstab
genfstab -U / >> /etc/fstab
echo "Enter root password"
passwd
useradd -m night
usermod -aG wheel,storage,power night
sudo sed -i "s/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL\nDefaults timestamp_timeout=600/" /etc/sudoers
sudo sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
echo "Enter hostname: "
read hostname
echo $hostname > /etc/hostname
cat > /mnt/etc/hosts <<EOF
127.0.0.1   localhost
::1         localhost
127.0.1.1   $hostname.localdomain   localhost
EOF
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock —-systohc


### Disable wifi powersave mode ###
LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
touch $LOC
echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC
sleep 2
sudo systemctl restart NetworkManager 
#wait for services to restore (looking at you DNS)
for i in {1..6} 
do
    echo -n "."
    sleep 1
done
sleep 2

# yay AUR helper
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
if [ -f /sbin/yay ]; then
    cd ..    
    # update the yay database
    yay -Suy --noconfirm
else
    # if this is hit then a package is missing, exit to review log
    exit
fi

### Install all of the above pacakges ####
yay -S --needed --noconfirm adobe-source-hans-sans-hk-fonts adobe-source-hans-jp-fonts adobe-source-hans-kr-fonts \
    autojump bat blueman bluez bluez-utils btop catppuccin-gtk-theme-mocha cliphist cmatrix \
    firefox fzf graphicsmagick grub-customizer grim gst-libav gst-plugins-good gtk3 gvfs jq kitty lf libva \
    libva-nvidia-driver-git linux-headers mako man-db mpv ncdu neofetch neovim network-manager-applet node \
    noto-fonts-emoji npm ntfs-3g nvidia-dkms nvidia-settings nwg-look-bin pacman-contrib pamixer \
    pavucontrol pdftricks pipewire phonon-qt5-gstreamer pipes.sh plymouth python-requests qt5-graphicaleffects \
    qt5-multimedia qt5-quickcontrols qt5-quickcontrols2 qt5-svg qt5-wayland qt5ct qt6ct qt6-wayland sddm-git slurp \
    swappy swaylock-effects swww sxiv thunar ttf-jetbrains-mono-nerd waybar wget wireplumber wl-clipboard wofi xdg-desktop-portal-hyprland zsh
# update config
sudo sed -i 's/MODULES=()/MODULES=(amdgpu nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
sudo sed -i '/^HOOKS=/ s/udev/& plymouth/' /etc/mkinitcpio.conf
sudo mkinitcpio -p linux --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
echo -e "options nvidia-drm modeset=1" | sudo tee -a /etc/modprobe.d/nvidia.conf
# Install the correct hyprland version
#check for hyprland and remove it so the -nvidia package can be installed
if yay -Q hyprland &>> /dev/null ; then
    yay -R --noconfirm hyprland
fi
install_software hyprland-nvidia
# Start the bluetooth service
sudo systemctl enable --now bluetooth
sleep 2
# Enable the sddm login manager service
sudo systemctl enable sddm
sleep 2 
# Clean out other portals
yay -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk

### Copy Config Files ###
cp -R .config ~/.config/

# Copy the SDDM theme
cd ~
git clone https://github.com/3ximus/aerial-sddm-theme aerial
sudo cp -R aerial /usr/share/sddm/themes/
sudo chown -R $USER:$USER /usr/share/sddm/themes/aerial
cd /usr/share/sddm/themes/aerial
rm -rf playlists screens README.md LICENSE .gitnore theme.conf.user background.jpg
cp ~/dotfiles/.data/aerial/night.m3u ~/dotfiles/.data/aerial/theme.conf.user ~/dotfiles/.config/background.png .
sudo mkdir /etc/sddm.conf.d
echo -e "[Theme]\nCurrent=aerial" | sudo tee -a /etc/sddm.conf.d/10-theme.conf &>> $INSTLOG

# stage the .desktop file
sudo mkdir /usr/share/wayland-sessions  
sudo cp ~/dotfiles/.data/misc/hyprland.desktop /usr/share/wayland-sessions/

# setup the first look and feel as dark
xfconf-query -c xsettings -p /Net/IconThemeName -s "Catppuccin-SE"
gsettings set org.gnome.desktop.interface icon-theme "Catppuccin-SE"
xfconf-query -c xsettings -p /Net/ThemeName -s "Catppuccin-Mocha-Standard-Lavender-dark"
gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Mocha-Standard-Lavender-dark"

# zsh
ln -sf ~/.config/zsh/.zshenv ~/.zshenv
cd ~/.config/zsh
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting

# plymouth
cd /usr/share/plymouth/themes/
sudo git clone https://github.com/farsil/monoarch
plymouth-set-default-theme -R monoarch

# grub
cd ~/dotfiles
sudo mv /etc/default/grub /etc/default/grub.bak # use this in case grub breaks
sudo cp .data/misc/grub /etc/default/grub
mkdir /boot/grub/themes/
sudo cp -r .data/misc/sayonara /boot/grub/themes/sayonara
sudo grub-mkconfig -o /boot/grub/grub.cfg
grub-install —target=x86_64-efi —bootloader-id=GRUB —recheck
grub-mkconfig -o /boot/grub/grub.cfg

# remove pacman stuff
sudo pacman -Rns $(pacman -Qdttq) # remove orphans
pacman -Qqd | pacman -Rsu -
sudo paccache -dvuk1

cd ~
curl -L -O https://github.com/ljmill/catppuccin-icons/releases/download/v0.2.0/Catppuccin-SE.tar.bz2
sudo tar -xf Catppuccin-SE.tar.bz2 -C /usr/share/icons

systemctl enable NetworkManager
echo "Install finished, type 'reboot'"
