#!/bin/bash

RED='\033[1;31m'
NC='\033[0m'

DOTFILES=(".aliases" ".bash_logout" ".bashrc"
    ".gitconfig" ".p10k.zsh" ".profile"
    ".vimrc" ".zshrc" ".zsh" "powerlevel10k"
)

function help() {
    echo "shell script for dotfiles management."
    echo
    echo "SYNOPSIS"
    echo "  dfs [OPTION]"
    echo
    echo "OPTIONS"
    echo "  -h, --help                  Display help"
    echo "  -i, --install               Install dotfiles"
    echo "  -u, --uninstall             Uninstall dotfiles"
    echo "  -b, --backup                Backup dotfiles"
    echo "  -ib, --install-binaries     Backup dotfiles"
    echo "  -ub, --uninstall-binaries   Backup dotfiles"
    exit
}

function check_path_dotfiles() {
    if [ ! -d ~/dotfiles/dfs ]; then
        echo -e "${RED}path doesn't exist: $HOME/dotfiles/dfs${NC}"
        echo "please run: 'cd ~ && git clone https://github.com/duken72/dotfiles.git'"
        exit
    fi
}

function check_path_binaries() {
    if [ ! -d ~/dotfiles/bin ]; then
        echo -e "${RED}path doesn't exist: $HOME/dotfiles/dfs${NC}"
        echo "please run: 'cd ~ && git clone https://github.com/duken72/dotfiles.git'"
        exit
    fi
}

function error-invalid-option() {
    echo -e "${RED}error: Invalid option${NC}"
    echo "check './dfs.sh --help' for valid ones."
    exit
}

function install_dotfiles() {
    check_path_dotfiles
    echo "install dotfiles at HOME = $HOME"
    echo "cleanup existing dotfiles"
    for DOTFILE in "${DOTFILES[@]}"; do
        if [ -L ~/$DOTFILE ]; then
            rm -v ~/$DOTFILE
        elif [ -f ~/$DOTFILE ] || [ -d ~/$DOTFILE ]; then
            mv -v ~/$DOTFILE "~/${DOTFILE}.bak"
        fi
    done
    echo "install new dotfiles"
    for DOTFILE in "${DOTFILES[@]}"; do
        ln -sv ~/dotfiles/dfs/$DOTFILE ~/$DOTFILE
    done
    echo "dotfiles are installed. Enjoy :)"
    exit
}

function uninstall_dotfiles() {
    echo "uninstall dotfiles at HOME = $HOME"
    for DOTFILE in "${DOTFILES[@]}"; do
        if [ -L ~/$DOTFILE ]; then
            rm -v ~/$DOTFILE
        fi
    done
    echo "dotfiles are uninstalled .. but .. why?? .. why meeeh :("
    exit
}

function backup_dotfiles() {
    echo "backup dotfiles at HOME = ${HOME}/dotfiles_backup"; echo
    if [ ! -d ~/dotfiles_backup ]; then
        mkdir -pv ~/dotfiles_backup
    fi
    for DOTFILE in "${DOTFILES[@]}"; do
        if ([ -f ~/$DOTFILE ] || [ -d ~/$DOTFILE ]) && [ ! -L ~/$DOTFILE ]; then
            mv -v ~/$DOTFILE ~/dotfiles_backup
        fi
    done
    echo "dotfiles are backed up"
    exit
}

function install_binaries() {
    check_path_binaries
    echo "install binaries at /usr/local/bin"
    echo "cleanup existing binaries"
    for BINARY in bin/*; do
        BINARY=${BINARY#"bin/"}
        if [ -f /usr/local/bin/$BINARY ]; then
            sudo rm -v /usr/local/bin/$BINARY
        fi
    done
    echo "install new binaries"
    for BINARY in bin/*; do
        BINARY=${BINARY#"bin/"}
        sudo ln -sv ~/dotfiles/bin/$BINARY /usr/local/bin/$BINARY
    done
    echo "binaries are installed. Enjoy :)"
    exit
}

function uninstall_binaries() {
    echo "uninstall binaries at /usr/local/bin"
    for BINARY in bin/*; do
        BINARY=${BINARY#"bin/"}
        if [ -L /usr/local/bin/$BINARY ]; then
            sudo rm -v /usr/local/bin/$BINARY
        fi
    done 
    echo "binaries are uninstalled :(("
    exit
}

########################################################
# MAIN
########################################################
while [ "$1" != "" ]; do
    case $1 in
        -h | --help)                help;;
        -i | --install)             install_dotfiles;;
        -u | --uninstall)           uninstall_dotfiles;;
        -b | --backup)              backup_dotfiles;;
        -ib | --install-binaries)   install_binaries;;
        -ub | --uninstall-binaries) uninstall_binaries;;
        *)                          error-invalid-option;;
    esac
    shift
done

echo -e "${RED}dfs: missing operand${NC}"
echo "try './dfs.sh --help' for more information."
