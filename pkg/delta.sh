#!/bin/bash

clear

echo "Change of AUR packages:"
if [ -f .pkg_aura.old ] && [ -f .pkg_aura.new ]; then
	delta .pkg_aura.old .pkg_aura.new
fi

echo "Change of pacman packages:"
if [ -f .pkg_pacman.old ] && [ -f .pkg_pacman.new ]; then
	delta .pkg_pacman.old .pkg_pacman.new
fi

echo "Change of python packages:"
if [ -f .pkg_pacman_python.txt ] && [ -f pkg_pacman_python.txt ]; then
	delta pkg_pacman_python.txt .pkg_pacman_python.txt
fi

echo "Change of latex packages:"
if [ -f .pkg_latex.txt ] && [ -f pkg_latex.txt ]; then
	delta pkg_latex.txt .pkg_latex.txt
fi
