#!/bin/bash

# LIBALPM hooks
sudo ln -svf ~/.dotfiles/dfs/hook/*.hook -t /usr/share/libalpm/hooks

# AURA - AUR helper
cd && mkdir -p WS && cd WS
git clone https://aur.archlinux.org/aura-bin.git
cd aura-bin && makepkg
ls | grep zst | sudo pacman -U -
rm -rf ~/WS/aura-bin

# Install packages
# when install pkg group, use ^x to exclude x
sudo pacman -Syu
for file in pkg_pacman pkg_pacman_sub pkg_pacman_python pkg_latex; do
	sudo pacman -S --needed - <"$file.txt"
done

sudo pacman -S --needed xorg xorg-xinit picom xdg-user-dirs lightdm-gtk-greeter \
	xfce4 xfce4-screensaver xfce4-screenshooter xfce4-notifyd xfce4-whiskermenu-plugin \
	zsh udisks2 ntfs-3g zip unzip \
	pulseaudio \
	ranger ueberzug ffmpegthumbnailer docx2txt ffmpeg atool \
	zathura zathura-pdf-mupdf \
	npm accountsservice redshift

sudo aura -Akax brave-bin cli-visualizer pulseaudio-ctl siji-git \
	tty-clock-git xfce4-panel-profiles
