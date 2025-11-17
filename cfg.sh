#!/bin/bash

RED='\033[1;31m'
GRN='\033[1;32m'
YLW='\033[1;33m'
BLU='\033[1;34m'
RST='\033[0m'
CONFIG_PATH="${HOME}/.dotfiles/config"

########################################################
# FUNCTIONS
########################################################
check_path() {
	if [ -d $CONFIG_PATH ]; then
		printf "%b Path exists: %b%b\n" $YLW $CONFIG_PATH $RST
	else
		printf "%b Path doesn't exists: %b%b\n" $RED $CONFIG_PATH $RST
		printf "%b Please run: \n git clone https://github.com/duken72/dotfiles.git ~/.dotfiles %b\n" $YLW $RST
		exit 1
	fi
}

help() {
	printf "%b Shell script for config management. %b\n\n" $BLU $RST
	printf "%b SYPNOSIS %b\n" $BLU $RST
	printf "  cfg [OPTION]\n\n"
	printf "%b OPTIONS %b\n" $BLU $RST
	printf " -h, --help \t\t Display help \n"
	printf " -i, --install \t\t Install config \n"
	printf " -u, --uninstall \t Uninstall config \n"
}

error() {
	printf "%b Error: Invalid / Missing operand %b\n" $RED $RST
	help
	exit 1
}

install() {
	printf "%b Install configs at $HOME/.config${RST} %b\n" $BLU $RST
	echo "-------------------------"

	find "$HOME/.dotfiles/config/" -type f -name "run.sh" | while read -r script; do
		printf "%b Executing: \t%b%b\n" $YLW $RST $script
		# Run the script (in its own directory)
		(cd "$(dirname "$script")" && ./$(basename "$script"))
		printf "%b Finished: \t%b%b\n" $GRN $RST $script
		echo "-------------------------"
	done

	printf "%b Installed configs. Enjoy!! :)) %b\n" $GRN $RST
}

uninstall() {
	printf "%b Uninstall configs at $HOME/.config %b\n" $BLU $RST
	echo "-------------------------"

	for path in "$HOME/.config"/*; do
		if [ -L "$path" ]; then
			printf "%b Removing config: %b%b\n" $YLW $RST $path
			rm "$path"
		fi
	done

	echo "-------------------------"
	printf "%b Uninstalled configs .. but .. why?? :( %b\n" $YLW $RST
}

########################################################
# MAIN
########################################################
check_path
case $1 in
-h | --help) help ;;
-i | --install) install ;;
-u | --uninstall) uninstall ;;
*) error ;;
esac
