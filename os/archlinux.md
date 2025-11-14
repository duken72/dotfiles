# ArchLinux

## Table of contents

<!-- vim-markdown-toc GFM -->

* [Installation](#installation)
* [Customization and tinkering](#customization-and-tinkering)
* [References](#references)

<!-- vim-markdown-toc -->

## Installation

- [To cleanly remove Windows](https://www.daangeurts.nl/blog/removing-windows-and-installing-arch-linux/)
- Check [Arch Linux wiki installation guide](https://wiki.archlinux.org/title/Installation_guide).
- Example videos: [1](https://youtu.be/HpskN_jKyhc), [2](https://youtu.be/cM2UDz8BepU), [3](https://youtu.be/DPLnBPM4DhI)
- **Note:** If you intend to use many Linux `distro`s, consider having a separate `/home` partition

0. Set font

   ```bash
   setfont /usr/share/kbd/consolefonts/ter-c20b...
   ```

1. Get the latest `iso` to USB thumb drive as a boot device
2. Could skip `iso` image verification, setting console keyboard layout
3. Verify boot mode:

   ```bash
   cat /sys/firmware/efi/fw_platform_size
   ```

   - If the command returns `64`, system boots in `64-bit x64 UEFI`
   - If the command returns `32`, system boots in `32-bit IA32 UEFI`
   - If the file doesn't exist, system boots in `BIOS` or `CSM` mode.

4. Setup network connection

   ```bash
   ip link
   iwctl
   [iwd]# device list
   [iwd]# station device_name scan
   [iwd]# station device_name get-networks
   [iwd]# station device_name connect SSID_name
   Ctrl+D to exit [iwd]
   ping archlinux.org
   ```

5. Use `timedatectl` to ensure the synchronized system clock

   ```bash
   timedatectl
   ```

6. Partition the disks

   ```bash
   lsblk              # to view Partitions
   cgdisk /dev/sda    # choose the largest Partition
   gdisk -l /dev/sda  # check if it's GPT or MBR
   ```

   - Create new partitions:
     - Boot partition, only for `UEFI` boot mode, not `BIOS`: first sector - `default`, second sector - `1G`, hex code - `ef00`, name - `boot`
     - Swap partition: first sector - `default`, second sector - `20G`, hex code - `8200`, name - `swap`.
       - **Note:** 20Gb swap for 16Gb of RAM, 35Gb swap for 32Gb of RAM.
       - Check RAM size with: `free -ght`
     - File system: first sector - `default`, second sector - `default`, hex code - `8300`, name - `root`
   - Format partitions

     ```bash
     mkfs.fat -F 32 /dev/boot_partition
     mkswap /dev/swap_partition
     mkfs.ext4 /dev/root_partition
     ```

   - Mount partitions

     ```bash
     mount /dev/root_partition /mnt
     swapon /dev/swap_partition
     mount --mkdir /dev/boot_partition /mnt/boot
     ```

7. Package Installation

   ```bash
   vim /etc/pacman.d/mirrorlist # Clean up the mirrorlist
   vim /etc/pacman.conf # ParallelDownloads = 7
   pacstrap -KP /mnt base base-devel linux linux-headers linux-firmware \
       sof-firmware networkmanager vim grub efibootmgr git intel-ucode
   # Old packages: linux-lts iw iwd
   ```

8. Configure the system

   ```bash
   genfstab -U /mnt >> /mnt/etc/fstab
   arch-chroot /mnt # enter system, to exit: exit

   # Set time zone, region/city is Europe/Berlin, check with Tab
   ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
   hwclock --systohc

   vim /etc/locale.gen # en_US.UTF-8 UTF-8
   locale-gen
   echo "LANG=en_US.UTF-8" > /etc/locale.conf
   echo "computer_name" > /etc/hostname
   echo "KEYMAP=us" > /etc/vconsole.conf

   mkinitcpio -P # (as long as the commands exit successfully)
   passwd # set root password
   ```

9. Create `bootloader`

- For `BIOS`, please refer to these tutorials:
  - `GPT`: [`Rouchage`](https://youtu.be/2YshYiYsvKA?si=PSiv8AeWSEZjEhwq)
  - `MBR`: [`DWIX`](https://youtu.be/7FD3gh8mLME?si=HWI_2UroJBEKcAyw)

- For `UEFI`:

  ```bash
  grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
  # Edit GRUB default time out
  sudo vim /etc/default/grub  # GRUB_TIMEOUT=1
  grub-mkconfig -o /boot/grub/grub.cfg

  exit # Exit and reboot. Pull out the flash drive.
  shutdown -r now
  ```

10. Setup network connection:
    - Login as root

      ```bash
      # show network device names (one wired and one wireless carrier)
      networkctl list

      # for networkmanager
      sudo systemctl enable --now NetworkManager
      nmcli device wifi list
      nmcli device wifi connect "SSID_or_BSSID" --ask
      nmcli device wifi connect "SSID_or_BSSID" password "password"

      # for iwd
      sudo systemctl enable --now iwd
      iwctl
      ```

    - Skip all network settings below, still works so far
    - Unsure if `iwd` or also `NetworkManager` need this.
      Create `config` files, with names of devices from the preceding:
      - Wired adapter: `/etc/systemd/network/20-wired.network`

        ```txt
        [Match]
        Name=eno1
        [Network]
        DHCP=yes
        [DHCP]
        RouteMetric=10
        ```

      - Wireless adapter: `/etc/systemd/network/25-wireless.network`

        ```txt
        [Match]
        Name=wlan0
        [Network]
        DHCP=yes
        [DHCP]
        RouteMetric=20
        ```

    - Enable and start the `systemd` services:

      ```bash
      systemctl enable --now systemd-networkd
      systemctl enable --now systemd-resolved
      ping google.com
      ```

11. Create users:

    ```bash
    useradd -g users -G wheel,storage,power,audio,video,optical -m user_name
    passwd user_name
    ln -svf /usr/bin/vim /usr/bin/vi
    visudo # uncomment %wheel ALL NOPASSWD ALL, can sudo without passwd

    # if openssh installed
    systemctl enable --now sshd
    ip addr
    ```

12. Drivers and packages installation:
    Clone the `dotfiles` and run the script:

    ```bash
    vim /etc/pacman.conf # ParallelDownloads = 5, Include multilib

    # choose suitable graphic drivers
    # lspci -v | grep -A1 -e VGA -e 3D
    sudo pacman -S xf86-video-intel                         # Intel graphic driver
    sudo pacman -S nvidia(-dkms) nvidia-utils nvidia-prime  # NVIDIA graphic driver
    cd ~ && git clone https://github.com/duken72/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles/pkg && ./pacman_install.sh
    ```

13. Post-installation: Setting up desktop environment\
    - Example videos: [vid_1](https://youtu.be/DAmXKDJ3D7M), [vid_2](https://youtu.be/eHdP4sT7-8U), [vid_3](https://youtu.be/FudOL0-B9Hs).

      ```bash
      systemctl enable lightdm
      systemctl list-unit-files --state=enabled
      reboot
      ```

    - Go to <https://archlinux.org/mirrorlist>, choose only `https`, not `http`, just `IPv4`, not `IPv6`, use mirror status.
      Remember to un-comment the server names, then resynchronize.

    - To provide domain name resolution for software that reads `/etc/resolv.conf`:

      ```bash
      sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
      ```

---

## Customization and tinkering

- Manage `XFCE` window manager hotkeys
- Applications
  - Online meeting: `zoom`
  - Trash management: `trash-cli`, `rmlint`
- Trouble-shooting
  - [No sound to speakers](https://bbs.archlinux.org/viewtopic.php?id=199067&p=2)
  - [Wi-Fi rtl8821ce driver problem](https://github.com/tomaspinho/rtl8821ce)
  - [Rolling back updates](https://linuxconfig.org/how-to-rollback-pacman-updates-in-arch-linux)
- Dual boot with Windows: make sure to install `fuse3`, such that when you run `sudo os-prober`, you can properly mount and detect a Windows system

---

## References

- [PACMAN](https://youtu.be/HD7jJEh4ZaM)
- [`AUR` Helper - `aura`](https://youtu.be/xPRJWHghWM8)
- [Tiling Window Managers](https://youtu.be/Obzf9ppODJU)
- [Dual boot with Ubuntu](https://www.linuxandubuntu.com/home/dual-boot-ubuntu-and-arch-linux)
