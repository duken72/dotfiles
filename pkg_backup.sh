#!/bin/bash

PKG_DIR=/home/duken72/dotfiles/pkg

# Clear content
> ${PKG_DIR}/pkg_pacman.txt
# > ${PKG_DIR}/pkg_group.txt

# Collect packages in package groups
PKG_GROUPS=("base-devel" "xfce4" "xfce4-goodies" "xorg")
if [ ! -f ${PKG_DIR}/pkg_group.txt ]; then
    for PKG_GROUP in "${PKG_GROUPS[@]}"; do
        pacman -Sg $PKG_GROUP | sd -s "${PKG_GROUP} " "" >> ${PKG_DIR}/pkg_group.txt
    done
fi
for PKG_GROUP in "${PKG_GROUPS[@]}"; do
    echo "$PKG_GROUP" >> ${PKG_DIR}/pkg_pacman.txt
done

# Backup packages
pacman -Qetq | grep texlive > ${PKG_DIR}/pkg_latex.txt
pacman -Qem | grep -v texlive > ${PKG_DIR}/pkg_aura.txt
pacman -Qten | grep -v texlive >> ${PKG_DIR}/pkg_pacman.txt
# Filter packages that are installed via pkg groups
while read pkg; do
    sed -i "/$pkg/d" ${PKG_DIR}/pkg_pacman.txt
done < ${PKG_DIR}/pkg_group.txt
# Special case coincidences
SPECIAL_PKGS=("cmake" "ripgrep" "pacman-contrib")
for PKG in "${SPECIAL_PKGS[@]}"; do
    pacman -Q $PKG >> ${PKG_DIR}/pkg_pacman.txt
done

# Reinstall when needed
# pacman -S --needed - < pkg_pacman.txt
# xargs sudo apt -y install < packages.txt
