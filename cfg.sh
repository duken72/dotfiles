#!/bin/bash

RED='\033[1;31m'
NC='\033[0m'

CONFIGS=(".moc" "autostart" "gtk-3.0" "htop" "neofetch" "nvim"
    "polybar" "pulseaudio-ctl" "ranger" "redshift" "rofi" "terminator"
    "vis" "vscode" "zathura" "user-dirs.locale" "glow"
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
    exit
}

function check_path() {
    if [ ! -d ~/dotfiles/config ]; then
        echo -e "${RED}path doesn't exist: $HOME/dotfiles/config${NC}"
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
    sudo cp ~/dotfiles/config/vconsole.conf /etc/vconsole.conf
    check_path
    echo "install config at HOME = $HOME/.config"
    for CONFIG in "${CONFIGS[@]}"; do
        ln -svbf --suffix='.bak' ~/dotfiles/config/$CONFIG -t ~/.config
    done
    cp ~/dotfiles/config/user-dirs.dirs ~/.config
    cd ~/dotfiles/config/xfce4/xfconf/xfce-perchannel-xml
    for FILE in *; do
        ln -svf ~/dotfiles/config/xfce4/xfconf/xfce-perchannel-xml/$FILE -t ~/.config/xfce4/xfconf/xfce-perchannel-xml
    done
    sudo ln -svf ~/dotfiles/config/TrueMinimalist -t /usr/share/themes
    mkdir -p ~/.local/share/icons
    sudo ln -svf ~/dotfiles/config/Night_Diamond_Red -t ~/.local/share/icons
    sudo ln -svf ~/dotfiles/config/redshift/*.svg -t /usr/share/icons/hicolor/scalable/apps
    # LightDM
    sudo cp ~/dotfiles/Wallpapers/syn* /usr/share/pixmaps
    sudo cp ~/dotfiles/config/LightDM/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf
    sudo cp ~/dotfiles/dfs/.face /var/lib/AccountsService/icons/duken72.png
    sudo cp ~/dotfiles/config/LightDM/duken72 /var/lib/AccountsService/users/duken72
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

########################################################
# MAIN
########################################################
while [ "$1" != "" ]; do
    case $1 in
        -h | --help)        help;;
        -i | --install)     install;;
        -u | --uninstall)   uninstall;;
        *)                  error;;
    esac
    shift
done

echo -e "${RED}cfg: missing operand${NC}"
echo "try './cfg.sh --help' for more information."
