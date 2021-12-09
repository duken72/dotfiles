#!/bin/sh

if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
fi

if ! updates_aur=$(aura -Qum 2> /dev/null | wc -l); then
    updates_aur=0
fi

updates=$((updates_arch + updates_aur))
if ! updates=$(aura -Qum 2> /dev/null | wc -l); then
    updates_aur=0
fi

if [ "$updates" -gt 27 ]; then
    echo "%{T4}%{T2} $updates"
else
    echo "%{T4}%{T2}"
fi
