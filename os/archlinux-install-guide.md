<!-- omit in toc -->
# Arch Linux

<!-- omit in toc -->
## Table of Contents

- [Installation](#installation)
- [General Guide](#general-guide)
- [Customization / Tinkering](#customization--tinkering)
  - [Applications](#applications)
  - [Setting up GPU for Deep Learning](#setting-up-gpu-for-deep-learning)
  - [PROBLEMS](#problems)

## Installation

- [To remove Windows completely](https://www.daangeurts.nl/blog/removing-windows-and-installing-arch-linux/)
- Check [Arch Linux wiki installation guide](https://wiki.archlinux.org/title/Installation_guide).
- Example videos: [1](https://youtu.be/HpskN_jKyhc), [2](https://youtu.be/cM2UDz8BepU), [3](https://youtu.be/DPLnBPM4DhI)
- **NOTE:** If you intend to use multiple distro, have a separate `/home` partition

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
     - Swap partition: first sector - default, 2nd sector - 1Gb, hex code - 8200, name - swap\
        **NOTE:** increase swap: 20Gb if 16Gb of RAM, 35Gb if 32Gb of RAM. Need 32Gb of RAM, 16Gb sucks.
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
    pacstrap /mnt base base-devel linux(-lts) linux-firmware sof-firmware
              iw iwd vim neovim grub efibootmgr openssh git
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
    ln -svf /usr/bin/vim /usr/bin/vi
    visudo # uncomment %wheel ALL NOPASSWD ALL, can sudo without passwd

    # if openssh installed
    systemctl start sshd
    systemctl enable sshd
    ip addr
    ```

13. Drivers and packages installation:
    Clone the dotfiles and run the script:

    ```bash
    # lspci -v | grep -A1 -e VGA -e 3D
    sudo pacman -S xf86-video-intel nvidia nvidia-utils # choose suitable graphic drivers
    vim /etc/pacman.conf # ParallelDownloads = 5
    cd ~ && git clone https://github.com/duken72/dotfiles.git
    cd ~/dotfiles/pkg && ./pacman_install.sh
    ```

    ```bash
    sudo pacman -S xorg xorg-xinit lightdm lightdm-gtk-greeter picom xdg-user-dirs \
                  xfce4 xfce4-screensaver xfce4-screenshooter \
                  xfce4-notifyd xfce4-whiskermenu-plugin  \
                  zsh fd htop terminator man-pages neofetch \
                  rofi polybar sxhkd udisks2 ntfs-3g zip unzip \
                  pulseaudio pavucontrol alsa-utils \
                  ranger ueberzug ffmpegthumbnailer docx2txt ffmpeg \
                  zathura zathura-pdf-mupdf \
                  # remove xfce4 terminal and the whole xfce4-goodies, except a few

    gawk '{print $1}' pkg_pacman.txt > /tmp/t.txt
    cd /tmp
    pacman -S - < t.txt # when install pkg group, use ^x to exclude x

    # AURA - AUR helper
    git clone https://aur.archlinux.org/aura-bin.git
    cd aura-bin
    makepkg
    sudo pacman -U aura-bin-...
    sudo aura -A xfce4-panel-profiles
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

## General Guide

- [PACMAN](https://youtu.be/HD7jJEh4ZaM)
- [AUR Helper - AURA](https://youtu.be/xPRJWHghWM8)
- [Tiling Window Managers](https://youtu.be/Obzf9ppODJU)

-------

## Customization / Tinkering

- Manage XFCE window manager hotkeys
- Window manager theme: [True Minimalist](https://www.xfce-look.org/p/1016640/) and [guide to install](https://wiki.xfce.org/howto/install_new_themes)
- Fonts: [JetBrainsNL Mono Nerd](https://archlinux.org/packages/community/any/ttf-jetbrains-mono-nerd/), size 11-12
- Mouse cursor: [Night Diamond theme](https://www.gnome-look.org/p/1295073/) and [Wiki guide](https://wiki.archlinux.org/title/Cursor_themes#XFCE)
- [Polybar](https://github.com/polybar/polybar): check Polybar wiki, also nice reference from [AbdelrhmanNile](https://github.com/AbdelrhmanNile/mydots_bspwm)
- Ranger: [image preview with ueberzug](https://github-wiki-see.page/m/ranger/ranger/wiki/Image-Previews), [video thumbnail with ffmpeg](https://www.reddit.com/r/NixOS/comments/74wftw/video_previews_wranger/), [docx2txt](http://docx2txt.sourceforge.net/)
- Zsh with terminator and [Powerlevel10k](https://dev.to/web3coach/best-terminal-setup-terminator-zsh-powerlevel10k-7pl)
- [Move between monitors](https://github.com/calandoa/movescreen)
- [Redshift](https://wiki.archlinux.org/title/redshift) and [Backlight](https://wiki.archlinux.org/title/backlight)
- Missing keyboard volume control: [Arch wiki](https://wiki.archlinux.org/title/Keyboard_input) and [pulseaudio-ctl](https://github.com/graysky2/pulseaudio-ctl) (get the key code with `showkey`, then setup keyboard shortcut to a `pulseaudio-ctl` command)
- Unibus-vn: [enable macro](https://github.com/vn-input/ibus-unikey/issues/11)
- [Rollback updates](https://linuxconfig.org/how-to-rollback-pacman-updates-in-arch-linux) to what is working
- Setting up [cleaning hooks](https://averagelinuxuser.com/clean-arch-linux/#1-clean-package-cache)
- [Pacman Tips and tricks](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Back_up_the_pacman_database)
- Replacement for G-HUB: [Libratbag](https://womanonrails.com/logitech-g915-tkl), and maybe [piper](https://github.com/libratbag/piper) as frontend application
- A bit troublesome with the [Osmos theme](https://github.com/Warinyourself/lightdm-webkit-theme-osmos)
- Terminus fonts as console font: put `vconsole.conf` in `/etc`

### Applications

- Email client in terminal: [Alpine](https://alpineapp.email/) ([bcacciaaudio.com](https://bcacciaaudio.com/2018/10/09/alpine-mail-setup-with-gmail/), [salixos.org](https://docs.salixos.org/wiki/How_to_set_up_Alpine_with_a_Gmail_account), [linuxshelltips.com](https://www.linuxshelltips.com/alpine-gmail-imap-in-linux/), [wesleyac.com](https://blog.wesleyac.com/posts/setting-up-alpine-gmail-with-arch-linux))
- Desktop system monitor: [Conky](https://github.com/brndnmtthws/conky) (fork from [xypnox](https://github.com/xypnox/dotfiles))
- 2FA: Authy
- Download manager: [xdman](https://xtremedownloadmanager.com/), [youtube-dl](https://youtube-dl.org/)
- Online meeting: zoom
- Cleaning: trash-cli, rmlint
- Bluetooth: blueberry, bluez-utils

-------

### Setting up GPU for Deep Learning

Follow this [guide](https://jaggu-iitm.medium.com/setting-up-deep-learning-with-cuda-tensorflow-and-keras-on-arch-linux-with-dual-gpu-nvidia-gpu-82963d2ecb75)

- You don't need to install and use `bumblebee`, `optimus-manager` or `prime` to use the GPU (either Intel or NVIDIA) for DL with `pytorch`/`tensorflow`

  ```bash
  sudo pacman -S cuda cudnn nvidia-dkms nvidia-utils
  sudo pacman -S 
  sudo pacman -S python-tensorflow-opt-cuda
  sudo pacman -S python-pytorch-opt-cuda
  ```

- Check in Python:

  ```python
  from tensorflow.python.client import device_lib
  device_lib.list_local_devices()
  import tensorflow as tf
  tf.config.list_physical_devices('GPU')

  import torch
  torch.cuda.is_available()
  ```

-------

### PROBLEMS

- [No sound to speakers](https://bbs.archlinux.org/viewtopic.php?id=199067&p=2)
- [Wi-Fi rtl8821ce driver problem](https://github.com/tomaspinho/rtl8821ce)
