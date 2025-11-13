#!/bin/bash

RED='\033[1;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
NC='\033[0m'

CONFIGS=(".moc" "autostart" "gtk-3.0" "neofetch" "nvim"
	"polybar" "pulseaudio-ctl" "ranger" "redshift" "rofi" "terminator"
	"vis" "zathura" "user-dirs.locale" "user-dirs.dirs" "glow"
)

if [ -d $HOME/.dotfiles/config ]; then
	CONFIG_PATH="${HOME}/.dotfiles/config"
	echo -e "${YELLOW}path exists: $CONFIG_PATH${NC}"
else
	echo -e "${RED}path doesn't exist: $HOME/.dotfiles/config${NC}"
	echo "please run: 'cd ~ && git clone https://github.com/duken72/dotfiles.git ~/.dotfiles'"
	exit
fi

function help() {
	echo "shell script for config management."
	echo
	echo "SYNOPSIS"
	echo "  cfg [OPTION]"
	echo
	echo "OPTIONS"
	echo "  -h, --help                  Display help"
	echo "  -i, --install               Install config"
	echo "  -u, --uninstall             Uninstall config"
	exit
}

function error() {
	echo -e "${RED}error: Invalid option${NC}"
	echo "check './cfg.sh --help' for valid ones."
	exit
}

function install() {
	echo -e "${YELLOW}Install configs at $HOME/.config${NC}"
	echo
	# for CONFIG in "${CONFIGS[@]}"; do
	# 	ln -svf $CONFIG_PATH/$CONFIG -t ~/.config
	# done
	find "$HOME/.dotfiles/config/" -type f -name "run.sh" | while read -r script; do
		echo -e "${YELLOW}Executing:${NC} $script"
		# Run the script (in its own directory)
		(cd "$(dirname "$script")" && ./$(basename "$script"))
		echo -e "${GREEN}Finished:${NC} $script"
		echo "-------------------------"
	done
	echo
	echo -e "${GREEN}Installed configs. Enjoy!! :))${NC}"
	exit
}

function uninstall() {
	echo "uninstall config at $HOME/.config"
	for CONFIG in "${CONFIGS[@]}"; do
		if [ -L ~/.config/$CONFIG ]; then
			rm -v ~/.config/$CONFIG
		fi
	done
	echo "config are uninstalled .. but .. why?? :("
	exit
}

########################################################
# MAIN
########################################################
while [ "$1" != "" ]; do
	case $1 in
	-h | --help) help ;;
	-i | --install) install ;;
	-u | --uninstall) uninstall ;;
	*) error ;;
	esac
	shift
done

echo -e "${RED}cfg: missing operand${NC}"
echo "try './cfg.sh --help' for more information."
