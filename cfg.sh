#!/bin/bash

RED='\033[1;31m'
NC='\033[0m'

CONFIGS=("autostart" "conky" "htop" "neofetch" "polybar"
    "ranger" "redshift" "rofi" "terminator" "vis" "zathura"
)

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
    echo "  -b, --backup                Backup config"
    exit
}

function check_path() {
    if [ ! -d ~/dotfiles/.config ]; then
        echo -e "${RED}path doesn't exist: $HOME/dotfiles/.config${NC}"
        echo "please run: 'cd ~ && git clone https://github.com/duken72/dotfiles.git'"
        exit
    fi
}

function error() {
    echo -e "${RED}error: Invalid option${NC}"
    echo "check './cfg.sh --help' for valid ones."
    exit
}

function install() {
    check_path
    echo "install config at HOME = $HOME/.config"
    echo "cleanup existing config"
    for CONFIG in "${CONFIGS[@]}"; do
        if [ -L ~/.config/$CONFIG ]; then
            rm -v ~/.config/$CONFIG
        elif [ -d ~/.config/$CONFIG ]; then
            mv -v ~/.config/$CONFIG "~/.config/${CONFIG}.bak"
        fi
    done
    echo "install new config"
    for CONFIG in "${CONFIGS[@]}"; do
        ln -sv ~/dotfiles/.config/$CONFIG ~/.config/$CONFIG
    done
    # cp -rv ~/dotfiles/.config/moc/* ~/.moc
    echo "config is installed. Enjoy :)"
    exit
}

function uninstall() {
    echo "uninstall config at HOME = $HOME/.config"
    for CONFIG in "${CONFIGS[@]}"; do
        if [ -L ~/.config/$CONFIG ]; then
            rm -v ~/.config/$CONFIG
        fi
    done
    echo "config are uninstalled .. but .. why?? :("
    exit
}

function backup() {
    echo "backup config at HOME = ${HOME}/config_backup"
    if [ ! -d ~/config_backup ]; then
        mkdir -pv ~/config_backup
    fi
    for CONFIG in "${CONFIGS[@]}"; do
        if [ -d ~/.config/$CONFIG ] && [ ! -L ~/.config/$CONFIG ]; then
            mv -iv ~/.config/$CONFIG ~/config_backup
        fi
    done
    # if [ -d ~/.moc ] && [ ! -L ~/.moc ]; then
    #     mv -iv ~/.moc ~/config_backup
    # fi
    echo "config are backed up"
    exit
}

########################################################
# MAIN
########################################################
while [ "$1" != "" ]; do
    case $1 in
        -h | --help)        help;;
        -i | --install)     install;;
        -u | --uninstall)   uninstall;;
        -b | --backup)      backup;;
        *)                  error;;
    esac
    shift
done

echo -e "${RED}cfg: missing operand${NC}"
echo "try './cfg.sh --help' for more information."
