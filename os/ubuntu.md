# Error and Fix in Ubuntu

20210608

- [Error and Fix in Ubuntu](#error-and-fix-in-ubuntu)
  - [no GUI, just login from terminal](#no-gui-just-login-from-terminal)
  - [No sound problem](#no-sound-problem)
  - [No Wi-Fi adapter found](#no-wi-fi-adapter-found)
  - [GRUB doesn't start - DUAL BOOT](#grub-doesnt-start---dual-boot)

-------

## no GUI, just login from terminal

- Solution: reinstall and run gdm3
- No dock: remove and reinstall gnome-extension ubuntu-dock

-------

## No sound problem

sudo alsa force-reload
sudo apt remove --purge alsa-base pulseaudio
sudo apt install alsa-base pulseaudio

-------

## No Wi-Fi adapter found

- Source: [theavgstud.blogspot](https://theavgstud.blogspot.com/2020/11/solved-wifi-adapter-not-found-ubuntu.html), [fosslinux](https://www.fosslinux.com/43345/fix-the-no-wi-fi-adapter-found-error-on-ubuntu.htm)
- Update system

    ```bash
    sudo apt-get update
    sudo apt-get upgrade

    lspci | grep Network
    ```

- If it's the Broadcom proceed to the next step.

    ```bash
    sudo apt-get install --reinstall bcmwl-kernel-source
    ```

- Enrolling MUC, provide password and reboot

-------

## GRUB doesn't start - DUAL BOOT

```bash
boot-repair

## Install first if needed
sudo add-apt-repository ppa:yannubuntu/boot-repair && sudo apt-get update
sudo apt-get install -y boot-repair && boot-repair
efibootmgr
```
