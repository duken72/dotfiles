#!/bin/bash

ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
sudo ln -svf $ABSOLUTE_PARENT_PATH/*.conf -t /etc/NetworkManager/conf.d
sudo ln -svf $ABSOLUTE_PARENT_PATH/svg/nm*.svg /usr/share/icons/hicolor/scalable/apps
sudo ln -svf $ABSOLUTE_PARENT_PATH/png/nm*.png -t /usr/share/icons/hicolor/22x22/apps
