#!/bin/bash

# This script displays the package changes after update/installation

BLU='\033[1;34m'
RST='\033[0m'

clear

printf "%b Change of pacman packages ... %b\n" "$BLU" "$RST"
delta .pkg_pacman.txt.bak .pkg_pacman.txt
echo

printf "%b Change of AUR packages ... %b\n" "$BLU" "$RST"
delta .pkg_aura.txt.bak .pkg_aura.txt
echo

printf "%b Change of python packages ... %b\n" "$BLU" "$RST"
delta pkg_pacman_python.txt .pkg_pacman_python.txt
echo

printf "%b Change of LaTeX packages ... %b\n" "$BLU" "$RST"
delta pkg_latex.txt .pkg_latex.txt
echo

printf "%b Alternatively, check /var/log/pacman.log %b\n" "$BLU" "$RST"
echo 'grep "upgraded" /var/log/pacman.log | grep $date'
# rg "upgraded" /var/log/pacman.log | rg "$date" > /tmp/pacman.log && bat /tmp/pacman.log
