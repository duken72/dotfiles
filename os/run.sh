#!/usr/bin/env bash

RED='\033[1;31m'
GRN='\033[1;32m'
YLW='\033[1;33m'
BLU='\033[1;34m'
RST='\033[0m'

#############################################
# Functions
#############################################

pre_partition() {
	printf "%b Verify the boot mode ... %b\n" "$BLU" "$RST"
	cat /sys/firmware/efi/fw_platform_size

	printf "%b Connect to the internet ... %b\n" "$BLU" "$RST"
	ip link
	iwctl
	ping archlinux.org

	printf "%b Update the system clock ... %b\n" "$BLU" "$RST"
	timedatectl

	printf "%b Please partition the disks manually! %b\n" "$YLW" "$RST"
	lsblk
}

format_and_mount_partitions() {
	# nvme0n1p5
	local boot_partition="TODO"
	local swap_partition="TODO"
	local root_partition="TODO"

	printf "%b Format the partitions ... %b\n" "$BLU" "$RST"
	mkfs.ext4 "/dev/$root_partition"
	mkfs.fat -F 32 "/dev/$boot_partition"
	mkswap "/dev/$swap_partition"

	printf "%b Mount the file systems ... %b\n" "$BLU" "$RST"
	mount "/dev/$root_partition" /mnt
	mount --mkdir "/dev/$boot_partition" /mnt/boot
	swapon "/dev/$swap_partition"

	printf "%b Please check the partitions! %b\n" "$YLW" "$RST"
	lsblk
}

installation() {
	vim /etc/pacman.d/mirrorlist # Clean up the mirrorlist
	vim /etc/pacman.conf         # ParallelDownloads = 7
	printf "%b Install essential packages ... %b\n" "$BLU" "$RST"
	pacstrap -KP /mnt base base-devel linux linux-headers linux-firmware \
		sof-firmware networkmanager vim grub efibootmgr git intel-ucode

	printf "%b Create needed Linux file systems with fstab ... %b\n" "$BLU" "$RST"
	genfstab -U /mnt >>/mnt/etc/fstab
}

configure() {
	# Set the time zone, check with Tab in /usr/share/zoneinfo/
	local timezone="TODO" # "Europe/Berlin"
	local hostname="TODO" # "Tux-IBP16-Arch"

	printf "%b Configure time zone ... %b\n" "$BLU" "$RST"
	ln -sf "/usr/share/zoneinfo/$timezone" /etc/localtime
	hwclock --systohc

	printf "%b Configure localization (lang, dates, etc.) ... %b\n" "$BLU" "$RST"
	vim /etc/locale.gen # en_US.UTF-8 UTF-8
	locale-gen
	echo "LANG=en_US.UTF-8" >/etc/locale.conf
	echo "$hostname" >/etc/hostname
	echo "KEYMAP=us" >/etc/vconsole.conf
	# sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

	# Usually not required, because mkinitcpio was run on installation of the
	# kernel package with pacstrap. Unless for LVM, RAID, sys encryption
	# mkinitcpio -P

	printf "%b Set root password ... %b\n" "$BLU" "$RST"
	passwd

	printf "%b Setup boot loader ... %b\n" "$BLU" "$RST"
	grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
	# Edit GRUB default time out
	sudo vim /etc/default/grub # GRUB_TIMEOUT=1
	grub-mkconfig -o /boot/grub/grub.cfg

	printf "%b Finished! %b\n" "$GRN" "$RST"
	printf "%b Please exit, reboot, and pull out the flash drive! %b\n" "$YLW" "$RST"
}

create_user() {
	local username="duken72"

	printf "%b Create user ... %b\n" "$BLU" "$RST"
	useradd -g users -G wheel,storage,power,audio,video,optical -m "$username"
	passwd "$user_name"
	ln -svf /usr/bin/vim /usr/bin/vi
	visudo # uncomment %wheel ALL NOPASSWD ALL, can sudo without passwd

	printf "%b Please reboot and login to the user account! %b\n" "$YLW" "$RST"
}

post_installation() {
	# vim /etc/pacman.conf # ParallelDownloads = 5, Include multilib
	local nvidia_gpu=false
	local intel_gpu=false

	printf "%b Install graphic driver ... %b\n" "$BLU" "$RST"
	lspci -v | grep -A1 -e VGA -e 3D
	if $intel_gpu; then
		printf "%b Install graphic driver for Intel GPU ... %b\n" "$BLU" "$RST"
		sudo pacman -S --needed xf86-video-intel
	fi
	if $nvidia_gpu; then
		printf "%b Install graphic driver for NVIDIA GPU ... %b\n" "$BLU" "$RST"
		# nvidia(-dkms) nvidia-utils nvidia-prime
		sudo pacman -S --needed nvidia nvidia-utils
	fi

	printf "%b Clone dotfiles repo ... %b\n" "$BLU" "$RST"
	cd ~ && git clone https://github.com/duken72/dotfiles.git ~/.dotfiles

	printf "%b Install and enable display manager ... %b\n" "$BLU" "$RST"
	sudo pacman -S --needed emptty
	systemctl enable emptty
	# systemctl enable lightdm
	printf "%b Please check if display manager is enabled! %b\n" "$YLW" "$RST"
	systemctl list-unit-files --state=enabled

	printf "%b Please reboot! %b\n" "$YLW" "$RST"
	# reboot
}

#############################################
# Main
#############################################
case "$1" in
1) pre_partition ;;
2) format_and_mount_partitions ;;
3) installation ;;
4) configure ;;
5) create_user ;;
6) post_installation ;;
*)
	printf "%b Error: Invalid option: %b %b\n" "$RED" "$1" "$RST"
	echo "Valid options: 1-6"
	echo "Eg: ./run.sh 1"
	exit 1
	;;
esac
