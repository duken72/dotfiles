#!/bin/bash

PKG_DIR=/home/duken72/.dotfiles/pkg

# Clear existing content in certain files (for later concatenation)
>${PKG_DIR}/pkg_pacman.txt
>${PKG_DIR}/.pkg_pacman.new
# >${PKG_DIR}/pkg_group.txt

# Collect packages in following package groups
# PKG_GROUPS=("base-devel" "xfce4" "xfce4-goodies" "xorg")
# for PKG_GROUP in "${PKG_GROUPS[@]}"; do
# 	pacman -Sg $PKG_GROUP | sd -s "${PKG_GROUP} " "" >>${PKG_DIR}/pkg_group.txt
# done

# Backup packages
pacman -Qem | grep -v debug >${PKG_DIR}/.pkg_aura.new
pacman -Qtn | grep -v python- | grep -v texlive >>${PKG_DIR}/.pkg_pacman.new

pacman -Qq | grep texlive >${PKG_DIR}/pkg_latex.txt
pacman -Qeq | grep python- >${PKG_DIR}/pkg_pacman_python.txt
pacman -Qeqm | grep -v debug >${PKG_DIR}/pkg_aura.txt
# pacman -Qtnq | grep -v python- | grep -v texlive >>${PKG_DIR}/pkg_pacman.txt

# Filter packages that are installed via pkg groups
while read pkg; do
	sed -i "/$pkg/d" ${PKG_DIR}/.pkg_pacman.new
	# sed -i "/$pkg/d" ${PKG_DIR}/pkg_pacman.txt
done <${PKG_DIR}/pkg_group.txt
