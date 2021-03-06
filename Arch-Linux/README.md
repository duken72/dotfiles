# Arch-Linux

## Installation

- [To remove Windows completely](https://www.daangeurts.nl/blog/removing-windows-and-installing-arch-linux/)
- Check [Arch Linux wiki installation guide](https://wiki.archlinux.org/title/Installation_guide).
- Example videos: [1](https://youtu.be/HpskN_jKyhc), [2](https://youtu.be/cM2UDz8BepU), [3](https://youtu.be/DPLnBPM4DhI),

1. Get the lastest iso to USB thumb drive as a boot device, consider using balenaEtcher.
2. Set root password: SKIP THIS

    ```bash
    passwd
    ```

3. Could skip iso image verification, setting console keyboard layout
4. Verify boot mode:

    ```bash
    ls /sys/firmware/efi/efivars
    ```

    Command exit with no error, file exists.

5. Setup network connection

    ```bash
    ip link
    iwctl
    help
    [iwd]# device list
    [iwd]# station device_name scan
    [iwd]# station device_name get-networks
    [iwd]# station device_name connect SSID_name
    Ctrl+D to exit [iwd]
    ping archlinux.org
    ```

6. Update system clock

    ```bash
    timedatectl set-ntp true
    timedatectl status #to check
    ```

7. Partition the disks

    ```bash
    lsblk #to view Partitions
    cgdisk /dev/sda #choose the largest Partition
    ```

   - Create new partitions:

     - Boot partition: first sector - default, 2nd sector - 512M, hex code - ef00 (recheck), name - boot
     - Swap partition: first sector - default, 2nd sector - 1GB, hex code - 8200, name - swap
     - File system: first sector - default, 2nd sector - default, hex code - 8300, name - arch??
   - Format partitions

      ```bash
      mkfs.fat -F 32 /dev/efi_system_partition (efi_system_partition is sda1, or sth, check lsblk)
      mkswap /dev/swap_partition (sda2)
      mkfs.ext4 /dev/root_partition (sda3)
      ```

   - Mount partitions

      ```bash
      mount /dev/root_partition /mnt (root_partition as sda3)
      swapon /dev/swap_partition
      mkdir -p /mnt/boot
      mount /dev/sda1 /mnt/boot
      ```

8. Package Installation

    ```bash
    vim /etc/pacman.d/mirrorlist # Clean up the mirrorlist
    vim /etc/pacman.conf # ParallelDownloads = 5
    pacstrap /mnt base base-devel linux-lts linux-firmware sof-firmware
              iw iwd vim grub efibootmgr openssh
    ```

9. Configure the system

    ```bash
    genfstab -U /mnt >> /mnt/etc/fstab
    arch-chroot /mnt # enter system, to exit: exit

    # Set time zone, region/city is Europe/Berlin, check with Tab
    ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
    hwclock --systohc

    vim /etc/locale.gen # en_US.UTF-8 UTF-8
    locale-gen
    vim /etc/locale.conf # LANG=en_US.UTF-8
    vim /etc/hostname # hostname (duken - arch)

    mkinitcpio -P # (as long as the commands exit successfully)
    passwd # set root password
    ```

10. Create bootloader

    ```bash
    # pacman -Sy grub efibootmgr
    grub-install --target=x86_64-efi --efi-directory=esp --bootloader-id=GRUB # esp is /boot
    grub-mkconfig -o /boot/grub/grub.cfg

    exit # Exit and reboot. Pull out the flash drive.
    shutdown -r now
    ```

11. Setup network connection:

    - Login as root

      ```bash
      systemctl start systemd-networkd
      systemctl start systemd-resolved
      networkctl list #to have the network device names, should be one wired and one carrier for wireless

      sudo systemctl start iwd
      sudo systemctl enable iwd
      iwctl #check also https://github.com/tomaspinho/rtl8821ce
      ```

    - Create config files, with names of devices from:

      ```bash
      networkctl list
      ```

    - Wired adapter: /etc/systemd/network/20-wired.network

      ```txt
      [Match]
      Name=eno1
      [Network]
      DHCP=yes
      [DHCP]
      RouteMetric=10
      ```

    - Wireless adapter: /etc/systemd/network/25-wireless.network

      ```txt
      [Match]
      Name=wlan0
      [Network]
      DHCP=yes
      [DHCP]
      RouteMetric=20
      ```

    - Restart the system to apply changes:

      ```bash
      systemctl restart systemd-networkd
      systemctl restart systemd-resolved
      systemctl enable systemd-networkd
      systemctl enable systemd-resolved
      ping google.com
      ```

12. Create users:

    ```bash
    useradd -g users -G wheel,storage,power,audio,video,optical -m user_name
    passwd user_name
    visudo #change %wheel ALL NOPASSWD ALL, can sudo without passwd

    # if openssh installed
    systemctl start sshd
    systemctl enable sshd
    ip addr
    ```

13. Drivers and packages installation:

    ```bash
    # lspci -v | grep -A1 -e VGA -e 3D
    vim /etc/pacman.conf # ParallelDownloads = 5
    (sudo) pacman -S xf86-video-intel nvidia nvidia-utils
                      xorg xorg-xinit lightdm lightdm-gtk-greeter picom
                      xfce4 xfce4-goodies xdg-user-dirs
                      zsh fd htop terminator git man-pages
                      pulseaudio pavucontrol alsa-utils
                      ranger rofi neofetch sxhkd udisks2 ntfs-3g zip unzip

    # AURA - AUR helper
    git clone https://aur.archlinux.org/aura-bin.git
    cd aura-bin
    makepkg
    sudo pacman -U aura-bin-...
    sudo aura -A polybar xfce4-panel-profiles
    ```

14. Post-installation: Setting up desktop environment\
Example videos: [vid_1](https://youtu.be/DAmXKDJ3D7M), [vid_2](https://youtu.be/eHdP4sT7-8U), [vid_3](https://youtu.be/FudOL0-B9Hs).

    ```bash
    systemctl enable lightdm
    systemctl list-unit-files --state=enabled
    reboot
    ```

    Go to <https://archlinux.org/mirrorlist>, choose only `https`, not `http`, just `IPv4`, not `IPv6`, use mirror status.
    Remember to uncomment the server names, then resynchronize.

-------

### GENERAL GUIDE

- [PACMAN](https://youtu.be/HD7jJEh4ZaM)
- [AUR Helper - AURA](https://youtu.be/xPRJWHghWM8)
- [Tiling Window Managers](https://youtu.be/Obzf9ppODJU)

### CUSTOMIZE

- Cursor: [Night Diamond theme](https://www.deviantart.com/biueguy/art/Night-Diamond-v3-0-Sapphire-Blue-177119871) and [Wiki guide](https://wiki.archlinux.org/title/Cursor_themes#XFCE)
- Polybar: check Polybar wiki, also nice reference from [AbdelrhmanNile](https://github.com/AbdelrhmanNile/mydots_bspwm)
- Ranger: [image preview with ueberzug](https://github-wiki-see.page/m/ranger/ranger/wiki/Image-Previews), [video thumbnail with ffmpeg](https://www.reddit.com/r/NixOS/comments/74wftw/video_previews_wranger/), [docx2txt](http://docx2txt.sourceforge.net/)
- Zsh with terminator and [Powerlevel10k](https://dev.to/web3coach/best-terminal-setup-terminator-zsh-powerlevel10k-7pl)
- [Move between monitors](https://github.com/calandoa/movescreen)
- Window manager theme: [True Minimalist](https://www.xfce-look.org/p/1016640/)
- Conky: fork from [xypnox](https://github.com/xypnox/dotfiles)
- [Redshift](https://wiki.archlinux.org/title/redshift) and [Backlight](https://wiki.archlinux.org/title/backlight)

### PROBLEMS

- [No sound to speakers](https://bbs.archlinux.org/viewtopic.php?id=199067&p=2)
- [Wifi rtl8821ce driver problem](https://github.com/tomaspinho/rtl8821ce)
- Missing keyboard volume control: [Arch wiki](https://wiki.archlinux.org/title/Keyboard_input) and [pulseaudio-ctl](https://github.com/graysky2/pulseaudio-ctl)
- Replacement for G-HUB: [Libratbag](https://womanonrails.com/logitech-g915-tkl)
- Unibus-vn: [enable Marco](https://github.com/vn-input/ibus-unikey/issues/11)
