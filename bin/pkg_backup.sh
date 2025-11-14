#!/bin/bash
# This Shell script back up package info after system update/package installation

###############################################################
# Init
###############################################################
RED='\033[1;31m'
YELLOW='\033[1;33m'
NC='\033[0m'
# This sript will be run as root, thus you can't use $USER or ~
PKG_DIR=/home/duken72/.dotfiles/pkg
echo -e "${YELLOW}The logfile directory:${NC}\t$PKG_DIR"

# Collect packages in following package groups, which are installed when using xorg & xfce4
# >${PKG_DIR}/pkg_xorg.txt
# PKG_GROUPS=("base-devel" "xfce4" "xfce4-goodies" "xorg")
# for PKG_GROUP in "${PKG_GROUPS[@]}"; do
# 	pacman -Sg $PKG_GROUP | sd -s "${PKG_GROUP} " "" >>${PKG_DIR}/pkg_xorg.txt
# done

###############################################################
# Backup AUR packages
###############################################################
echo -e "${YELLOW}Backup AUR pkg at:${NC}\t${PKG_DIR}/.pkg_aura.txt"
pacman -Qem | grep -v debug >${PKG_DIR}/.pkg_aura.txt

###############################################################
# Backup PACMAN packages
###############################################################
echo -e "${YELLOW}Backup pacman pkg at:${NC}\t${PKG_DIR}/.pkg_pacman.txt"
# Clear existing content in certain files (for later concatenation)
# >${PKG_DIR}/.pkg_pacman.txt
# pacman -Qtn | grep -v python- | grep -v texlive >>${PKG_DIR}/.pkg_pacman.txt
pacman -Qtn | grep -v python- | grep -v texlive >${PKG_DIR}/.pkg_pacman.txt

# Filter packages that are installed via pkg groups when using xorg & xfce4
if [ -n "$DISPLAY" ] || [ -S /tmp/.X11-unix/X0 ]; then
	echo "Using xorg"
	while read pkg; do
		sed -i "/$pkg/d" ${PKG_DIR}/.pkg_pacman.txt
	done <${PKG_DIR}/pkg_xorg.txt
fi

echo -e "${YELLOW}Backup latex pkg at:${NC}\t${PKG_DIR}/.pkt_latex.txt"
pacman -Qq | grep texlive >${PKG_DIR}/.pkg_latex.txt

echo -e "${YELLOW}Backup python pkg at:${NC}\t${PKG_DIR}/.pkg_python.txt"
pacman -Qeq | grep python- >${PKG_DIR}/.pkg_pacman_python.txt
