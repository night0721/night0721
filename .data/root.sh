timedatectl set-timezone Europe/London
cfdisk /dev/nvme0n1
echo "Enter root partition: "
read rootpart
echo "Enter home partition: "
read homepart
echo "Enter swap partition: "
read swappart
echo "Enter EFI partition: "
read efipart
mkfs.ext4 $rootpart
mkfs.ext4 $homepart
mkswap $swappart
swapon $swappart
mount $rootpart /mnt
mount -mkdir $homepart /mnt/home
mount -mkdir $efipart /mnt/boot/efi/
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
pacman -Syu
pacman -S pacman-contrib
rankmirrors -n 10 /etc/pacman.d/mirrorlist.bak > /etc/pacman.d/mirrorlist
pacstrap -i /mnt base base-devel linux linux-headers linux-firmware amd-ucode sudo git networkmanager pulseaudio grub efibootmgr dosfstools mtools os-prober
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt ./install.sh
