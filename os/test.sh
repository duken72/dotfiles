#!/bin/bash

# my supervisor Robert Schirmer :3

COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

# git output in PS1
function git_color {
	local git_status="$(git status 2>/dev/null)"

	if [[ ! $git_status =~ "working tree clean" ]]; then
		echo -e $COLOR_RED
	elif [[ $git_status =~ "Your branch is ahead of" ]]; then
		echo -e $COLOR_YELLOW
	elif [[ $git_status =~ "nothing to commit" ]]; then
		echo -e $COLOR_GREEN
	else
		echo -e $COLOR_OCHRE
	fi
}

function git_branch {
	local git_status="$(git status 2>/dev/null)"
	local on_branch="On branch ([^${IFS}]*)"
	local on_commit="HEAD detached at ([^${IFS}]*)"

	if [[ $git_status =~ $on_branch ]]; then
		local branch=${BASH_REMATCH[1]}
		echo "($branch)"
	elif [[ $git_status =~ $on_commit ]]; then
		local commit=${BASH_REMATCH[1]}
		echo "($commit)"
	fi
}

PS1+="\[\$(git_color)\]"                  # colors git status
PS1+="\$(git_branch)"                     # prints current branch
PS1+="\[$COLOR_BLUE\]\$\[$COLOR_RESET\] " # '#' for root, else '$'

#line 60
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# THIS is the part to change for other colors     ^
# 1 red, 2 green, 3 yellow, 4 blue etc...
