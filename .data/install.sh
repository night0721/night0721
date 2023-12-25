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
yay -S --needed adobe-source-han-sans-{hk,jp,kr}-fonts bat bemenu bluez bluez-utils brightnessctl \
    btop chafa firefox foot fzf graphicsmagick grub-customizer grim gtk3 hugo lf libliftoff libnotify \
    linux-headers mako man-db mpv ncdu neovim newsboat noto-fonts-emoji npm ntfs-3g nvidia-open \
    pacman-contrib pass pipewire-{alsa,pulse} plymouth python-{mutagen,pip} ripgrep slurp socat swappy \
    tllist tmux ttf-jetbrains-mono-nerd unzip wf-recorder wireplumber wl-clipboard wlroots-nvidia \
    wlr-randr xdg-desktop-portal-wlr xorg-xhost yt-dlp zathura zathura-pdf-poppler zip zsh --noconfirm > /dev/null

# update config
sudo sed -i 's/MODULES=()/MODULES=(vfio vfio_iommu_type1 vfio_pci amdgpu nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
sudo sed -i '/^HOOKS=/ s/udev/& plymouth/' /etc/mkinitcpio.conf
# add modconf to HOOKS
sudo mkinitcpio -p linux --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
echo -e "options nvidia-drm modeset=1" | sudo tee -a /etc/modprobe.d/nvidia.conf


sudo systemctl enable --now bluetooth
sleep 2
#sudo systemctl enable sddm
#sleep 2 

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
#cd /dotfiles
#sudo git clone https://github.com/3ximus/aerial-sddm-theme aerial
#sudo cp -R aerial /usr/share/sddm/themes/
#sudo chown -R $USER:$USER /usr/share/sddm/themes/aerial
#cd /usr/share/sddm/themes/aerial
#rm -rf playlists screens .git README.md LICENSE .gitignore theme.conf.user background.jpg
#cp /dotfiles/.data/aerial/night.m3u /dotfiles/.data/aerial/theme.conf.user /dotfiles/.config/background.png .
#sudo mkdir /etc/sddm.conf.d
#sudo touch /etc/sddm.conf.d/10-theme.conf
#echo -e "[Theme]\nCurrent=aerial" | sudo tee -a /etc/sddm.conf.d/10-theme.conf

# /etc/hosts
cd /dotfiles/.data/misc
curl -L -O https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
sudo cp hosts /etc/hosts

# autojump
cd /home/night
git clone git://github.com/wting/autojump.git
cd autojump
./install.py

# stage the .desktop file
sudo mkdir /usr/share/wayland-sessions
sudo cp /dotfiles/.data/misc/dwl.desktop /usr/share/wayland-sessions/

# setup the first look and feel as dark
gsettings set org.gnome.desktop.interface icon-theme "Catppuccin-SE"
gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Mocha-Standard-Lavender-Dark"
gsettings set org.gnome.desktop.interface cursor-theme "Catppuccin-Mocha-Lavender-Cursors"

# suckless stuff
cd ~
mkdir repos
cd repos
git clone https://codeberg.org/night0721/dwl
cd dwl
sudo make install
cd ..
git clone https://codeberg.org/night0721/dwl-bar
sudo make install
cd ..
git clone https://codeberg.org/night0721/someblocks
sudo make install
cd ..
git clone https://codeberg.org/dnkl/wbg
meson --buildtype=release build
ninja -C build
sudo ninja -C build install
cd ..

# zsh
ln -sf /home/night/.config/zsh/.zshenv /home/night/.zshenv
# cd /home/.config/zsh
# git clone https://github.com/zsh-users/zsh-autosuggestions
#git clone https://github.com/zsh-users/zsh-syntax-highlighting

# plymouth
cd /usr/share/plymouth/themes/
sudo git clone https://github.com/farsil/monoarch > /dev/null
sudo plymouth-set-default-theme -R monoarch > /dev/null
cd monoarch
sudo rm -rf .git LICENSE README.md

# grub
sudo mount --mkdir $efipart /boot/efi/
#sudo mount --mkdir $windowspart /run/media/N
cd /dotfiles
sudo mv /etc/default/grub /etc/default/grub.bak # use this in case grub breaks
sudo cp .data/misc/grub /etc/default/grub
sudo mkdir -p /boot/grub/themes
sudo cp -r .data/misc/n /boot/grub/themes/n
sudo grub-install —-target=x86_64-efi --efi-directory=/boot/efi —-bootloader-id=Arch —-recheck
sudo grub-mkconfig -o /boot/grub/grub.cfg

# remove pacman stuff
sudo pacman -Rns $(pacman -Qdttq) --noconfirm > /dev/null # remove orphans
pacman -Qqd | pacman -Rsu - > /dev/null
sudo paccache -dvuk1 > /dev/null

# npm
npm config set prefix '~/.local/npm'

# gtk icons
cd /home/night
curl -L -O https://github.com/ljmill/catppuccin-icons/releases/download/v0.2.0/Catppuccin-SE.tar.bz2
sudo tar -xf Catppuccin-SE.tar.bz2 -C /usr/share/icons

# gtk theme -> https://github.com/catppuccin/gtk
curl -L -O https://github.com/catppuccin/gtk/releases/latest/download/Catppuccin-Mocha-Standard-Lavender-Dark.zip
sudo unzip Catppuccin-Mocha-Standard-Lavender-Dark.zip -d /usr/share/themes

# cursor theme -> https://github.com/catppuccin/cursors
curl -L -O https://github.com/catppuccin/cursors/releases/latest/download/Catppuccin-Mocha-Lavender-Cursors.zip
sudo unzip Catppuccin-Mocha-Lavender-Cursors.zip -d /usr/share/icons

printf "$nightpasswd\n" | chsh -s /usr/bin/zsh
sudo usermod -aG wheel,storage,power,lp,libvirt,kvm,libvirt-qemu,input,disk,audio,video night
sudo systemctl enable --now NetworkManager
echo "Install finished, type 'reboot'"
