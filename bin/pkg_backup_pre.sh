#!/bin/bash

# This Shell script back up package info before system update/package installation
# This sript will be run as root. Can't use $USER, ~, $XDG_SESSION_TYPE

RED='\033[1;31m'
YLW='\033[1;33m'
BLU='\033[1;34m'
RST='\033[0m'

PKG_DIR=/home/duken72/.dotfiles/pkg
printf "%b The logfile directory: %b\t%b\n" $BLU $RST $PKG_DIR

###############################################################
# Backup AUR packages
printf "%b Backup AUR pkg at: %b\t\t%b/.pkg_aura.txt.bak\n" $BLU $RST $PKG_DIR
if [ -e ${PKG_DIR}/.pkg_aura.txt ]; then # Copy from current file
	cp ${PKG_DIR}/.pkg_aura.txt ${PKG_DIR}/.pkg_aura.txt.bak
else # Create new backup
	pacman -Qem | grep -v debug >${PKG_DIR}/.pkg_aura.txt.bak
fi

###############################################################
# Backup PACMAN packages
printf "%b Backup pacman pkg at: %b\t\t%b/.pkg_pacman.txt.bak\n" $BLU $RST $PKG_DIR
# Copy from current file
if [ -e ${PKG_DIR}/.pkg_pacman.txt ]; then
	cp ${PKG_DIR}/.pkg_pacman.txt ${PKG_DIR}/.pkg_pacman.txt.bak
	exit
fi

# Create new backup
pacman -Qtn | grep -v python- | grep -v texlive >${PKG_DIR}/.pkg_pacman.txt.bak

if [ -n "$WAYLAND_DISPLAY" ] || [ -S /run/user/$(id -u)/wayland-0 ]; then
	display_server="wayland"
else
	# if [ -n "$DISPLAY" ] || [ -S /tmp/.X11-unix/X0 ]; then
	display_server="xorg"
fi

while read pkg; do
	sed -i "/$pkg/d" ${PKG_DIR}/.pkg_pacman.txt.bak
done <${PKG_DIR}/pkg_${display_server}.txt
