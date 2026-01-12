#!/bin/sh

efipart=$(awk -F' ' '{print $1}' /dotparts)
windowspart=$(awk -F' ' '{print $2}' /dotparts)

nightpasswd=$(awk -F' ' '{print $1}' /dotpass)

# clear the screen
clear

cd /home/night
pacman -Syu --noconfirm > /dev/null

### Install all of the above pacakges ####
sudo pacman -S --needed asciinema bluez bluez-utils brightnessctl chafa \
    dos2unix firefox foot grim hugo imagemagick iwd lf libgit2 libnotify \
    libsodium libwebsockets mako mandoc mpv ncdu neovim newsboat \
    noto-fonts-emoji npm ntfs-3g nvidia-open openssh pass pipewire-pulse \
    python-pytube slurp socat swappy wf-recorder wlroots wl-clipboard \
    xdg-desktop-portal-wlr yt-dlp --noconfirm > /dev/null

# update config
sudo sed -i 's/MODULES=()/MODULES=(amdgpu nouveau)/' /etc/mkinitcpio.conf
# sudo sed -i 's/MODULES=()/MODULES=(vfio vfio_iommu_type1 vfio_pci amdgpu)/' /etc/mkinitcpio.conf # for qemu passthrough
sudo mkinitcpio -p linux --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img

### Copy Config Files ###
cp -R /dotfiles/* /home/night/

# /etc/hosts
cd /dotfiles/.data/misc
curl -L -O https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
sudo mv hosts /etc/hosts

# suckless stuff
cd ~
mkdir repos
cd repos
git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
cd ble.sh
make -C ble.sh install PREFIX=~/.local
cd ..
git clone https://github.com/night0721/aureate
cd aureate
make
sudo make install
cd ..
git clone https://codeberg.org/dwl/dwl
cd dwl
git switch wlroots-next
patch < ~/.data/patches/dwl.patch
make 
sudo make install
cd ..
git clone https://codeberg.org/night0721/wbg
cd wbg
meson --buildtype=release build
ninja -C build
sudo ninja -C build install
cd ..
git clone https://github.com/night0721/fnf
cd fnf
make
sudo make install
cd ..
git clone https://github.com/night0721/sloc
cd sloc
make
sudo make install
cd ..
git clone https://github.com/night0721/kat
cd kat
make
sudo mv kat /usr/local/bin
cd ..
git clone https://github.com/night0721/nvimpager
cd nvimpager
make PREFIX=$HOME/.local install
cd ..

# bash
ln -sf /home/night/.profile /home/night/.bashrc
ln -sf /home/night/.profile /home/night/.bash_profile

# grub
cd /dotfiles
sudo cp .data/misc/grub /etc/default/grub
sudo mkdir -p /boot/grub/themes
sudo cp -r .data/misc/n /boot/grub/themes/n
sudo grub-install —-target=x86_64-efi --efi-directory=/boot/efi —-bootloader-id=Arch —-recheck
sudo grub-mkconfig -o /boot/grub/grub.cfg

# instead of grub, I now use efistub
efibootmgr --create --label "Alpain" --disk "/dev/nvme0n1" --part "1" --loader "\vmlinuz-lts" --unicode "root=UUID=93b78e35-1c63-4fd3-922d-cf855f86c90f loglevel=3 quiet splash udev.log_priority=3 vt.global_cursor_default=1 amdgpu.backlight=0 modules=sd-mod,usb-storage,ext4,nvme rootfstype=ext4 rw initrd=\initramfs-lts" --verbose

# misc
cleansystem
sudo find /usr/share/fonts/adobe-source-han-sans -type f ! -name "SourceHanSansHK-Normal.otf" -delete

cd ~
mkdir fonts
cd fonts
curl -L -O https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Monaspace.zip
unzip Monaspace.zip
sudo mkdir /usr/share/fonts/TTF
sudo mv MonaspiceKrNerdFont-*.otf /usr/share/fonts/TTF
cd ..
rm -rf fonts

sudo mv /usr/share/fonts/adobe-source-han-sans/SourceHanSansHK-Normal.otf /usr/share/fonts/TTF
sudo pacman -Rcns adobe-source-han-sans-hk-fonts

printf "$nightpasswd\n" | chsh -s /usr/bin/bash

sudo usermod -aG wheel,storage,power,lp,input,disk,audio,video night
# sudo usermod -aG wheel,storage,power,lp,libvirt,kvm,libvirt-qemu,input,disk,audio,video night # with qemu
sudo systemctl enable --now connman iwd bluetooth 
echo "Install finished, type 'reboot'"

# void https://github.com/elbachir-one/dotfiles/blob/main/install.sh
