#!/bin/bash

# LIBALPM hooks
echo "Setting up LIBALPM hooks..."
sudo ln -svf ~/.dotfiles/dfs/hook/*.hook -t /usr/share/libalpm/hooks
echo ""

# AURA - AUR helper
echo "Installing AURA..."
if ! type aura >/dev/null; then
	mkdir -p ~/WS && cd ~/WS && git clone https://aur.archlinux.org/aura-bin.git
	cd ~/WS/aura-bin && makepkg && ls | grep zst | sudo pacman -U - && rm -rf ~/WS/aura-bin
else
	echo "aura already installed."
fi
sudo aura -Aax aic94xx-firmware ast-firmware upd72020x-fw wd719x-firmware
echo ""

# Install packages
# when install pkg group, use ^x to exclude x
echo "Installing pacman packages..."
sudo pacman -Syu
for file in pkg_group pkg_pacman pkg_latex; do
	sudo pacman -S --needed - <"/home/$USER/.dotfiles/pkg/$file.txt"
done
echo ""

echo "Installing AUR packages..."
sudo aura -Aax brave-bin pulseaudio-ctl
sudo aura -Aax moc-pulse tty-clock-git cli-visualizer
# sudo aura -Aax skypeforlinux-bin slack-desktop zoom python311 zotero
# xfce4-panel-profiles
echo ""

echo "Removing orphans..."
pacman -Qtdq | sudo pacman -Rns -
echo ""

echo "Installation completed."
