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
cd ..    
yay -Syu --noconfirm > /dev/null

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

### Disable wifi powersave mode ###
LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
sudo mkdir -p /etc/NetworkManager/conf.d
sudo touch $LOC
echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC

### Copy Config Files ###
cp -R /dotfiles/.config /dotfiles/.local /home/night/

# /etc/hosts
cd /dotfiles/.data/misc
curl -L -O https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
sudo cp hosts /etc/hosts

# autojump
cd /home/night
git clone https://github.com/wting/autojump.git
cd autojump
./install.py

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
git clone https://codeberg.org/night0721/wbg
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

# misc
bat cache --build # catppuccin theme for bat
sudo sed -i 's/dmenu-wl/bemenu/' /usr/bin/passmenu # fix passmenu not using bemenu
echo -e 'if lsmod | grep -wq "pcspkr"; then                                     
  sudo rmmod pcspkr # Remove annoying beep sound in tty
fi

if [[ $TTY == /dev/tty1 ]]; then
    dwl -d &> ~/dwl.log # For no display manager
fi' | sudo tee -a /etc/profile # profile to autostart  
printf "$nightpasswd\n" | chsh -s /usr/bin/zsh
sudo usermod -aG wheel,storage,power,lp,libvirt,kvm,libvirt-qemu,input,disk,audio,video night
sudo systemctl enable --now NetworkManager
echo "Install finished, type 'reboot'"
