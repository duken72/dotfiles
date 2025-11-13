#!/bin/bash

exit
sudo pacman -S --needed --noconfirm openvpn openresolv
sudo wget "https://raw.githubusercontent.com/ProtonVPN/scripts/master/update-resolv-conf.sh" -O "/etc/openvpn/update-resolv-conf"
sudo chmod +x "/etc/openvpn/update-resolv-conf"

# openvpn --config *.ovpn --auth-user-pass openvpn_pass.txt
