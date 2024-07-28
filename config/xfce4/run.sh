#!/bin/bash

ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
ln -svf $ABSOLUTE_PARENT_PATH/xfconf/xfce-perchannel-xml/* -t ~/.config/xfce4/xfconf/xfce-perchannel-xml
ln -svf $ABSOLUTE_PARENT_PATH/*.rc -t ~/.config/xfce4
ln -svf $ABSOLUTE_PARENT_PATH/xfce4-screenshooter -t ~/.config/xfce4
