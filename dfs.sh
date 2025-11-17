#!/bin/bash

RED='\033[1;31m'
GRN='\033[1;32m'
YLW='\033[1;33m'
BLU='\033[1;34m'
RST='\033[0m'

DOTFILES_PATH="${HOME}/.dotfiles/dfs"
BINARIES_PATH="${HOME}/.dotfiles/bin"
DOTFILES=(".aliases" ".bash_logout" ".bashrc" ".gitconfig" ".profile" ".face"
	".pythonrc" ".vimrc" ".p10k.zsh" ".zshrc" ".zsh" ".powerlevel10k" ".zkbd"
	".clang-format"
)

########################################################
# FUNCTIONS
########################################################

help() {
	printf "%b Shell script for dotfile management. %b\n\n" $BLU $RST
	printf "%b SYPNOSIS %b\n" $BLU $RST
	printf " dfs [OPTION]\n\n"
	printf "%b OPTIONS %b\n" $BLU $RST
	printf " -h, --help \t\t\t Display help \n"
	printf " -i, --install \t\t\t Install dotfiles \n"
	printf " -u, --uninstall \t\t Uninstall dotfiles \n"
	printf " -ib, --install-binaries \t Install binaries \n"
	printf " -ub, --uninstall-binaries \t Uninstall binaries \n"
}

check_paths() {
	if [ ! -d $DOTFILES_PATH ] || [ ! -d $BINARIES_PATH ]; then
		printf "%b Path doesn't exists: \n%b\n%b%b\n" $RED $DOTFILES_PATH $BINARIES_PATH $RST
		printf "%b Please run: \n git clone https://github.com/duken72/dotfiles.git ~/.dotfiles %b\n" $YLW $RST
		exit 1
	else
		printf "%b Paths exists: %b%b\n" $GRN $DOTFILES_PATH $RST
		printf "%b Paths exists: %b%b\n" $GRN $BINARIES_PATH $RST
	fi
}

error() {
	printf "%b Error: Invalid / Missing operand %b\n" $RED $RST
	help
	exit 1
}

install_dotfiles() {
	printf "%b Install dotfiles at %b %b\n" $BLU $HOME $RST

	echo "-------------------------"
	for DOTFILE in "${DOTFILES[@]}"; do
		ln -svf ~/.dotfiles/dfs/$DOTFILE -t ~/
	done

	echo "-------------------------"
	printf "%b Change default SHELL to zsh %b\n" $BLU $RST
	[[ ! $SHELL == *"zsh" ]] && chsh -s $(which zsh)

	echo "-------------------------"
	printf "%b Installed dotfiles. Enjoy!! :)) %b\n" $GRN $RST
}

uninstall_dotfiles() {
	printf "%b Uninstall dotfiles at %b %b\n" $BLU $HOME $RST
	echo "-------------------------"

	for DOTFILE in "${DOTFILES[@]}"; do
		if [ -L ~/$DOTFILE ]; then
			rm -v ~/$DOTFILE
		fi
	done

	echo "-------------------------"
	printf "%b Change default SHELL to bash %b\n" $BLU $RST
	[[ ! $SHELL == *"bash" ]] && chsh -s $(which bash)

	echo "-------------------------"
	printf "%b Uninstalled dotfiles .. but .. why?? .. why meeh :( %b\n" $YLW $RST
}

install_binaries() {
	printf "%b Install binaries at /usr/local/bin %b\n" $BLU $RST

	echo "-------------------------"
	for BINARY in bin/*; do
		BINARY=${BINARY#"bin/"}
		sudo ln -svf ~/.dotfiles/bin/$BINARY -t /usr/local/bin
	done

	echo "-------------------------"
	printf "%b Installed binaries. Enjoy!! :)) %b\n" $GRN $RST
}

uninstall_binaries() {
	printf "%b Uninstall binaries at /usr/local/bin %b\n" $BLU $RST
	echo "-------------------------"

	for BINARY in bin/*; do
		BINARY=${BINARY#"bin/"}
		if [ -L /usr/local/bin/$BINARY ]; then
			sudo rm -v /usr/local/bin/$BINARY
		fi
	done

	echo "-------------------------"
	printf "%b Uninstalled binaries .. but .. why?? .. why meeh :( %b\n" $YLW $RST
}

########################################################
# MAIN
########################################################
check_paths
case $1 in
-h | --help) help ;;
-i | --install) install_dotfiles ;;
-u | --uninstall) uninstall_dotfiles ;;
-ib | --install-binaries) install_binaries ;;
-ub | --uninstall-binaries) uninstall_binaries ;;
*) error ;;
esac
