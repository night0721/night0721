#!/bin/sh

efipart=$(awk -F' ' '{print $1}' /dotparts)
windowspart=$(awk -F' ' '{print $2}' /dotparts)

nightpasswd=$(awk -F' ' '{print $1}' /dotpass)

# clear the screen
clear

cd /home/night
pacman -Syu --noconfirm > /dev/null

### Install all of the above pacakges ####
sudo pacman -S --needed adobe-source-han-sans-{hk,jp,kr}-fonts bat bemenu bluez bluez-utils brightnessctl \
    btop chafa firefox foot fzf graphicsmagick grub-customizer grim  hugo lf libliftoff libnotify mako \
    man-db mpv ncdu neovim newsboat noto-fonts-emoji npm ntfs-3g nvidia-open pacman-contrib pass \
    pipewire-{alsa,pulse} plymouth python-{mutagen,pip} ripgrep slurp socat swappy tllist tmux unzip \
    wf-recorder wireplumber wl-clipboard wlroots wlr-randr xdg-desktop-portal-wlr xorg-xhost yt-dlp zathura \
    zathura-pdf-poppler zip zsh --noconfirm > /dev/null

# update config
sudo sed -i 's/MODULES=()/MODULES=(amdgpu nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
# sudo sed -i 's/MODULES=()/MODULES=(vfio vfio_iommu_type1 vfio_pci amdgpu nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf # for qemu passthrough
sudo sed -i '/^HOOKS=/ s/udev/& plymouth/' /etc/mkinitcpio.conf
# add modconf to HOOKS
sudo mkinitcpio -p linux --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
echo -e "blacklist nouveau\noptions nvidia_drm modeset=1 fbdev=1" | sudo tee -a /etc/modprobe.d/nvidia.conf


sudo systemctl enable --now bluetooth
sleep 2

### Disable wifi powersave mode ###
LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
sudo mkdir -p /etc/NetworkManager/conf.d
sudo touch $LOC
echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC

### Copy Config Files ###
cp -R /dotfiles/.config /dotfiles/.local /dotfiles/.npmrc /dotfiles/.github /dotfiles/.gitignore /dotfiles/data /home/night/

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

# plymouth
cd /usr/share/plymouth/themes/
sudo git clone https://github.com/farsil/monoarch > /dev/null
sudo plymouth-set-default-theme -R monoarch > /dev/null
cd monoarch
sudo rm -rf .git LICENSE README.md

# grub
cd /dotfiles
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
echo -e 'root ALL=(ALL:ALL) ALL
n ALL=(ALL:ALL) ALL
%wheel ALL=(ALL:ALL) NOPASSWD: ALL
@includedir /etc/sudoers.d' | sudo tee -a /etc/sudoers

cd ~
mkdir fonts
curl -L -O https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
curl -L -O https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Monaspace.zip
unzip Monaspace.zip
unzip JetBrainsMono.zip
sudo mkdir /usr/share/fonts/TTF
sudo mv MonaspiceKrNerdFont* /usr/share/fonts/TTF
sudo mv JetBrainsMonoNerdFont* /usr/share/fonts/TTF
cd ..
rm -rf fonts

printf "$nightpasswd\n" | chsh -s /usr/bin/zsh

sudo usermod -aG wheel,storage,power,lp,input,disk,audio,video night
# sudo usermod -aG wheel,storage,power,lp,libvirt,kvm,libvirt-qemu,input,disk,audio,video night # with qemu
sudo systemctl enable --now NetworkManager
echo "Install finished, type 'reboot'"
