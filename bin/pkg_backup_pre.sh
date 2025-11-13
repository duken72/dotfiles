#!/bin/bash
# This Shell script back up package info before system update/package installation

###############################################################
# Init
###############################################################
RED='\033[1;31m'
YELLOW='\033[1;33m'
NC='\033[0m'
# This sript will be run as root, thus you can't use $USER or ~
PKG_DIR=/home/duken72/.dotfiles/pkg
echo -e "${YELLOW}The logfile directory:${NC}\t$PKG_DIR"

###############################################################
# Backup AUR packages
###############################################################
echo -e "${YELLOW}Backup AUR pkg at:${NC}\t${PKG_DIR}/.pkg_aura.txt.bak"
if [ -e ${PKG_DIR}/.pkg_aura.txt ]; then
	# Copy from current file
	cp ${PKG_DIR}/.pkg_aura.txt ${PKG_DIR}/.pkg_aura.txt.bak
else
	# Create new backup
	pacman -Qem | grep -v debug >${PKG_DIR}/.pkg_aura.txt.bak
fi

###############################################################
# Backup PACMAN packages
###############################################################
echo -e "${YELLOW}Backup pacman pkg at:${NC}\t${PKG_DIR}/.pkg_pacman.txt.bak"
if [ -e ${PKG_DIR}/.pkg_pacman.txt ]; then
	# Copy from current file
	cp ${PKG_DIR}/.pkg_pacman.txt ${PKG_DIR}/.pkg_pacman.txt.bak
else
	# Create new backup
	pacman -Qtn | grep -v python- | grep -v texlive >>${PKG_DIR}/.pkg_pacman.txt.bak

	# XDG_SESSION_TYPE will be missing when running as root
	# thus, you can check for indicators in the system
	# if [ "$XDG_SESSION_TYPE" = "x11" ]; then
	# if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
	# if [ -n "$WAYLAND_DISPLAY" ] || [ -S /run/user/$(id -u)/wayland-0 ]; then
	# 	echo "Wayland"

	# Filter packages that are installed via pkg groups when using xorg & xfce4
	if [ -n "$DISPLAY" ] || [ -S /tmp/.X11-unix/X0 ]; then
		while read pkg; do
			sed -i "/$pkg/d" ${PKG_DIR}/.pkg_pacman.txt.bak
		done <${PKG_DIR}/pkg_xorg.txt
	fi
fi
