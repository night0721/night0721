timedatectl set-timezone Europe/London
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
#cfdisk /dev/nvme0n1
#echo "Enter root partition: "
#read rootpart
rootpart=/dev/nvme0n1p4
#echo "Enter home partition: "
#read homepart
homepart=/dev/nvme0n1p6
#echo "Enter swap partition: "
#read swappart
swappart=/dev/nvme0n1p7
#echo "Enter EFI partition: "
#read efipart
efipart=/dev/nvme0n1p1

echo "Enter night password"
read nightpasswd

echo "Enter root password"
read rootpasswd

echo "Enter hostname"
read hostname

mkfs.ext4 $rootpart
mkfs.ext4 $homepart
mkswap $swappart
swapon $swappart
mount $rootpart /mnt
mount --mkdir $homepart /mnt/home
mount --mkdir $efipart /mnt/boot/efi/
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
pacman -Syu
pacman -S pacman-contrib --noconfirm
rankmirrors -n 10 /etc/pacman.d/mirrorlist.bak > /etc/pacman.d/mirrorlist
pacstrap -i /mnt base base-devel linux linux-headers linux-firmware amd-ucode sudo git networkmanager pulseaudio grub efibootmgr dosfstools mtools os-prober --noconfirm
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt /bin/bash -- << EOCHROOT
useradd -m night
usermod -aG wheel,storage,power night
usermod --password $nightpasswd night
echo $rootpasswd | passwd --stdin root
sed -i "s/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL\nDefaults timestamp_timeout=600/" /etc/sudoers
sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
echo $hostname > /etc/hostname
cat > /etc/hosts <<EOF
127.0.0.1   localhost
::1         localhost
127.0.1.1   $hostname.localdomain   localhost
EOF
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock —w
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
EOCHROOT
cp ~/dotfiles/.data/install.sh /mnt/install.sh
arch-chroot -u night /mnt bash /install.sh
