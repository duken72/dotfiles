#!/bin/bash

PKG_DIR=/home/duken72/.dotfiles/pkg

# Collect packages in following package groups
# >${PKG_DIR}/pkg_group.txt
# PKG_GROUPS=("base-devel" "xfce4" "xfce4-goodies" "xorg")
# for PKG_GROUP in "${PKG_GROUPS[@]}"; do
# 	pacman -Sg $PKG_GROUP | sd -s "${PKG_GROUP} " "" >>${PKG_DIR}/pkg_group.txt
# done

# Backup packages
# AUR packages
pacman -Qem | grep -v debug >${PKG_DIR}/.pkg_aura.new

# Clear existing content in certain files (for later concatenation)
>${PKG_DIR}/.pkg_pacman.new
pacman -Qtn | grep -v python- | grep -v texlive >>${PKG_DIR}/.pkg_pacman.new

# Filter packages that are installed via pkg groups
while read pkg; do
	sed -i "/$pkg/d" ${PKG_DIR}/.pkg_pacman.new
done
# done <${PKG_DIR}/pkg_group.txt

pacman -Qq | grep texlive >${PKG_DIR}/.pkg_latex.txt
pacman -Qeq | grep python- >${PKG_DIR}/.pkg_pacman_python.txt
