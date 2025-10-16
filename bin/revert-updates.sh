#!/bin/bash

# This script reverts all pacman updates on specified date (and possibly time)
# if you still keep the packages cache in /var/cache/pacman/pkg

# Date should be in this format: yyyy-mm-dd
DATE="$1"
echo "Revert pacman updates on $DATE"
grep -a $DATE /var/log/pacman.log | grep upgraded >/tmp/upd.txt
gawk '{gsub(/\(/,""); gsub(/\)/,""); print $4"-"$5}' /tmp/upd.txt >/tmp/pkgs.txt

cd /var/cache/pacman/pkg/
for pkg in $(cat /tmp/pkgs.txt); do
	sudo pacman --needed --noconfirm -U "$pkg"*.zst
done
