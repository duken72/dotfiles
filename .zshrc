# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Created by newuser for 5.8
source ~/powerlevel10k/powerlevel10k.zsh-theme

# HISTORY
HISTSIZE=570
SAVEHIST=570
HISTFILE="$HOME/.history"
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

# https://github.com/zsh-users/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# ln -s /usr/share/git/completion/git-completion.zsh ~/.zsh/completion/_git
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i


# Key binding
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char
source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
    [[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
    [[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char
    # etc.

## ROS2
#export ROS_DOMAIN_ID=72
#export ROS_VERSION=2
#export ROS_PYTHON_VERSION=3
#export ROS_DISTRO=foxy
#source /opt/ros2/foxy/setup.zsh
#source /usr/share/colcon_cd/function/colcon_cd.sh
#export _colcon_cd_root=/opt/ros/foxy
#source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh
