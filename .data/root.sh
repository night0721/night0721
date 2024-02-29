timedatectl set-timezone Europe/London
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
if [ ! -f "/dotparts" ]; then
    echo "'dotparts' file not found, I have created one for you. Please edit the file with only one line and have fields"
    echo "[EFI Partition] [Windows Partition] [Root Partition] [Home Partition]"
    echo ""
    echo "Example:"
    echo "/dev/nvme0n1p1 /dev/nvme0n1p3 /dev/nvme0n1p6 /dev/nvme0n1p7"
    touch /dotparts
    exit
fi
efipart=$(awk -F' ' '{print $1}' /dotparts)
windowspart=$(awk -F' ' '{print $2}' /dotparts)
rootpart=$(awk -F' ' '{print $3}' /dotparts)
homepart=$(awk -F' ' '{print $4}' /dotparts)
if [ ! -f "/dotpass" ]; then
    echo "'dotpass' file not found, I have created one for you. Please edit the file with only one line and have fields"
    echo "[Night Password] [Root Password]"
    echo ""
    echo "Example:"
    echo "123 123"
    touch /dotpass
    exit
fi
nightpasswd=$(awk -F' ' '{print $1}' /dotpass)
rootpasswd=$(awk -F' ' '{print $2}' /dotpass)
if [ ! -f "/dothostname" ]; then
    echo "'dothostname' file not found, I have created one for you. Please edit the file with only one line and have fields"
    echo "[Hostname]"
    echo ""
    echo "Example:"
    echo "123"
    touch /dothostname
    exit
fi
hostname=$(cat /dothostname)
mkfs.ext4 $rootpart
mkfs.ext4 $homepart
mount $rootpart /mnt
mount --mkdir $homepart /mnt/home
mount --mkdir $efipart /mnt/boot/efi/
mount --mkdir $windowspart /mnt/mnt/windows
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
pacman -S pacman-contrib --noconfirm > /dev/null
rankmirrors -n 10 /etc/pacman.d/mirrorlist.bak > /etc/pacman.d/mirrorlist
pacstrap -i /mnt base base-devel linux linux-headers linux-firmware git networkmanager grub efibootmgr dosfstools mtools os-prober --noconfirm > /dev/null
genfstab -U /mnt >> /mnt/etc/fstab
rmmod pcspkr # speaker for no beeping as it is annoying
arch-chroot /mnt /bin/bash -- << EOCHROOT
useradd -m -G wheel,audio,storage,power -s /bin/bash night
printf "$nightpasswd\n$nightpasswd" | passwd night
printf "$rootpasswd\n$rootpasswd" | passwd root
sed -i "s/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL\nDefaults timestamp_timeout=600/" /etc/sudoers
sed -i -e 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
echo $hostname > /etc/hostname
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock —w
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
EOCHROOT
cp -r dotfiles/ /mnt/
# cp dotfiles/.data/install.sh /mnt/install.sh
arch-chroot -u night /mnt su -c /dotfiles/.data/install.sh -s /bin/sh night &> /dev/null
