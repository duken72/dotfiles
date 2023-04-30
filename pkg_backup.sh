#!/bin/bash

PKG_DIR=/home/duken72/dotfiles/pkg

# Clear content
> ${PKG_DIR}/pkg_pacman.txt
> ${PKG_DIR}/pkg_group.txt

# Collect packages in package groups
PKG_GROUPS=("base-devel" "xfce4" "xfce4-goodies" "xorg")
for PKG_GROUP in "${PKG_GROUPS[@]}"; do
    pacman -Sg $PKG_GROUP | sd -s "${PKG_GROUP} " "" >> ${PKG_DIR}/pkg_group.txt
done

# Backup packages
pacman -Qetq | grep texlive- > ${PKG_DIR}/pkg_latex.txt
pacman -Qetq | grep python- > ${PKG_DIR}/pkg_pacman_python.txt
pacman -Qem | grep -v texlive- > ${PKG_DIR}/pkg_aura.txt
pacman -Qten | grep -v texlive- | grep -v python- >> ${PKG_DIR}/pkg_pacman.txt
# Filter packages that are installed via pkg groups
while read pkg; do
    sed -i "/$pkg/d" ${PKG_DIR}/pkg_pacman.txt
done < ${PKG_DIR}/pkg_group.txt

# Reinstall when needed
# check pkg/pacman_install.sh
# xargs sudo apt -y install < packages.txt

# To specify package version, if they exist in /var/cache/pacman/pkg
# pacman -S --needed - < pkg_pacman.txt
