#!/bin/bash

# This Shell script back up package info after system update/package installation
# This sript will be run as root. Can't use $USER, ~, $XDG_SESSION_TYPE

RED='\033[1;31m'
YLW='\033[1;33m'
BLU='\033[1;34m'
RST='\033[0m'

PKG_DIR=/home/duken72/.dotfiles/pkg
printf "%b The logfile directory: %b\t%b\n" $BLU $RST $PKG_DIR

# Backup AUR packages
printf "%b Backup AUR pkg at: %b\t\t%b/.pkg_aura.txt\n" $BLU $RST $PKG_DIR
pacman -Qem | grep -v debug >${PKG_DIR}/.pkg_aura.txt

# Backup PACMAN packages
printf "%b Backup pacman pkg at: %b\t\t%b/.pkg_pacman.txt\n" $BLU $RST $PKG_DIR
pacman -Qtn | grep -v python- | grep -v texlive >${PKG_DIR}/.pkg_pacman.txt
# Filter packages depending on display server and window manager
if [ -n "$WAYLAND_DISPLAY" ] || [ -S /run/user/$(id -u)/wayland-0 ]; then
	display_server="wayland"
else
	display_server="xorg"
fi
while read pkg; do
	sed -i "/$pkg/d" ${PKG_DIR}/.pkg_pacman.txt
done <${PKG_DIR}/pkg_${display_server}.txt

# Backup LaTeX packages
printf "%b Backup LaTeX pkg at: %b\t\t%b/.pkg_latex.txt\n" $BLU $RST $PKG_DIR
pacman -Qq | grep texlive >${PKG_DIR}/.pkg_latex.txt

# Backup Python packages
printf "%b Backup Python pkg at: %b\t\t%b/.pkg_python.txt\n" $BLU $RST $PKG_DIR
pacman -Qeq | grep python- >${PKG_DIR}/.pkg_python.txt

#############################################################
# Old--References
exit
# Collect packages in following package groups,
# which are installed when using xorg & xfce4
>${PKG_DIR}/pkg_xorg.txt
PKG_GROUPS=("base-devel" "xfce4" "xfce4-goodies" "xorg")
for PKG_GROUP in "${PKG_GROUPS[@]}"; do
	pacman -Sg $PKG_GROUP | sd -s "${PKG_GROUP} " "" >>${PKG_DIR}/pkg_xorg.txt
done

# if [ -n "$DISPLAY" ] || [ -S /tmp/.X11-unix/X0 ]; then
