#!/bin/bash

# This bash script displays the differences between files
# Thus, showing the changes of packages after update/installation

clear

echo "Change of pacman packages:"
delta .pkg_pacman.old .pkg_pacman.new
echo ""

echo "Change of AUR packages:"
delta .pkg_aura.old .pkg_aura.new
echo ""

echo "Change of python packages:"
delta pkg_pacman_python.txt .pkg_pacman_python.txt
echo ""

echo "Change of latex packages:"
delta pkg_latex.txt .pkg_latex.txt
echo ""

# Alternative: check /var/log/pacman.log
# rg "upgraded" /var/log/pacman.log | rg "$date" > /tmp/pacman.log && bat /tmp/pacman.log
