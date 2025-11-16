#!/bin/bash

RED='\033[1;31m'
GRN='\033[1;32m'
YLW='\033[1;33m'
BLU='\033[1;34m'
RST='\033[0m'

########################################################
# FUNCTIONS
########################################################

setup_libalpm_hooks() {
	printf "%b Setting up LIBALPM hooks... %b\n" "$BLU" "$RST"
	sudo ln -svf ~/.dotfiles/dfs/hook/*.hook -t /usr/share/libalpm/hooks
}

install_aura() {
	if ! type aura >/dev/null; then
		printf "%b Install AURA ... %b\n" "$BLU" "$RST"
		mkdir -p ~/WS && cd ~/WS && git clone https://aur.archlinux.org/aura-bin.git
		cd ~/WS/aura-bin && makepkg && ls | grep zst | sudo pacman -U - && rm -rf ~/WS/aura-bin
	else
		printf "%b AURA is already installed. %b\n" "$GRN" "$RST"
	fi
}

install_packages() {
	printf "%b Check if AURA has been installed ... %b\n" "$BLU" "$RST"
	install_aura
	echo

	printf "%b System upgrade ... %b\n" "$BLU" "$RST"
	sudo pacman -Syu
	echo

	printf "%b Install missing module firmware with AURA ... %b\n" "$BLU" "$RST"
	sudo aura -Aax aic94xx-firmware ast-firmware upd72020x-fw wd719x-firmware
	echo

	# when install pkg group, use ^x to exclude x
	printf "%b Install pacman packages ... %b\n" "$BLU" "$RST"
	for file in pkg_pacman; do
		sudo pacman -S --needed - <"/home/$USER/.dotfiles/pkg/$file.txt"
	done
	echo

	printf "%b Install AUR packages ... %b\n" "$BLU" "$RST"
	sudo aura -Aax brave-bin tty-clock-git
	echo

	printf "%b Remove orphan packages ... %b\n" "$BLU" "$RST"
	pacman -Qtdq | sudo pacman -Rns -
	echo

	printf "%b Installation completed. %b\n" "$GRN" "$RST"
}

install_packages_latex() {
	printf "%b Install pacman packages for LaTeX ... %b\n" "$BLU" "$RST"
	read -r -p "Are you sure you want to continue? [y/N]: " reply
	reply=${reply:-n} # Default to "no" if user just presses Enter
	case "$reply" in
	[Yy]*)
		for file in pkg_latex; do
			sudo pacman -S --needed - <"/home/$USER/.dotfiles/pkg/$file.txt"
		done
		;;
	*)
		printf "%b Cancelled! %b\n" "$YLW" "$RST"
		;;
	esac
}

install_packages_python() {
	printf "%b Install pacman packages for python ... %b\n" "$BLU" "$RST"
	read -r -p "Are you sure you want to continue? [y/N]: " reply

	reply=${reply:-n} # Default to "no" if user just presses Enter

	case "$reply" in
	[Yy]*)
		for file in pkg_pacman_python; do
			sudo pacman -S --needed - <"/home/$USER/.dotfiles/pkg/$file.txt"
		done
		;;
	*)
		printf "%b Cancelled! %b\n" "$YLW" "$RST"
		;;
	esac
}

########################################################
# MAIN
########################################################
case $1 in
1) setup_libalpm_hooks ;;
2) install_packages ;;
3) install_packages_python ;;
4) install_packages_latex ;;
*)
	printf "%bError: Invalid option: %b %b\n" "$RED" "$1" "$RST"
	echo "Valid options: 1-4"
	echo "Eg: ./pacman_install.sh 1"
	exit 1
	;;
esac
