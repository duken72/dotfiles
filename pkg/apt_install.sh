#!/bin/bash

# xargs sudo apt -y install < packages.txt
sudo apt update
sudo apt install -y vim git tree tmux fd-find zsh \
	neofetch htop ranger terminator ncdu \
	slack curl

# Install Brave browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install -y brave-browser

# Install fastfetch: upstream PPA, since apt has it only from Ubuntu 25.04
sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
sudo apt update
sudo apt install -y fastfetch

# Install ueberzugpp (ranger image previews) from the upstream openSUSE build
# service repo. It has builds for Ubuntu 24.04 or newer only, not for 22.04.
UBUNTU_VERSION=$(. /etc/os-release && echo "$VERSION_ID")
UEBERZUGPP_REPO="https://download.opensuse.org/repositories/home:/justkidding/xUbuntu_${UBUNTU_VERSION}"
if curl -fsIo /dev/null "$UEBERZUGPP_REPO/Release.key"; then
	curl -fsSL "$UEBERZUGPP_REPO/Release.key" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_justkidding.gpg >/dev/null
	echo "deb $UEBERZUGPP_REPO/ /" | sudo tee /etc/apt/sources.list.d/home:justkidding.list
	sudo apt update
	sudo apt install -y ueberzugpp
else
	echo "No ueberzugpp repo for Ubuntu $UBUNTU_VERSION, skipping"
fi

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
cd ~/.fzf && ./install
sudo mv bin/* /usr/bin
rm -rf ~/.fzf

# Install JetBrains Mono Nerd Font
cd ~/Downloads
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
mkdir -p JetBrainsMonoNLNerdFont
tar xvf JetBrainsMono.tar.xz -C ~/Downloads/JetBrainsMonoNLNerdFont
sudo mv ~/Downloads/JetBrainsMonoNLNerdFont /usr/share/fonts

# Install git-delta
cd ~/Downloads
wget https://github.com/dandavison/delta/releases/download/0.15.1/git-delta-musl_0.15.1_amd64.deb
sudo dpkg -i git-delta-musl_0.15.1_amd64.deb

# Install exa
cd ~/Downloads
wget https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip
unzip exa-linux-x86_64-v0.10.0.zip
sudo mv bin/exa /usr/bin

# Install neovim
cd ~/Downloads
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version
# Exposing nvim globally.
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
sudo apt install -y npm lua5.3
