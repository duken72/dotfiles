if [[ "$(hostname)" == "panda-ctrl11" ]]; then
    # Path to your oh-my-zsh installation.
    export ZSH="$HOME/.oh-my-zsh"

    ZSH_THEME="agnoster"

    # Use case-sensitive completion.
    CASE_SENSITIVE="true"

    # Case-sensitive completion must be off. _ and - will be interchangeable.
    HYPHEN_INSENSITIVE="true"

    # Uncomment one of the following lines to change the auto-update behavior
    zstyle ':omz:update' mode auto      # update automatically without asking

    # Uncomment the following line to change how often to auto-update (in days).
    zstyle ':omz:update' frequency 14

    # Uncomment the following line if pasting URLs and other text is messed up.
    # DISABLE_MAGIC_FUNCTIONS="true"

    # Uncomment the following line to enable command auto-correction.
    ENABLE_CORRECTION="true"

    # Uncomment the following line if you want to disable marking untracked files
    # under VCS as dirty. This makes repository status check for large repositories
    # much, much faster.
    DISABLE_UNTRACKED_FILES_DIRTY="true"

    # Uncomment the following line if you want to change the command execution time
    # stamp shown in the history command output.
    # You can set one of the optional three formats:
    # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
    # or set a custom format using the strftime function format specifications,
    # see 'man strftime' for details.
    # HIST_STAMPS="mm/dd/yyyy"

    # Would you like to use another custom folder than $ZSH/custom?
    # ZSH_CUSTOM=/path/to/new-custom-folder

    # Which plugins would you like to load?
    # Standard plugins can be found in $ZSH/plugins/
    # Custom plugins may be added to $ZSH_CUSTOM/plugins/
    # Example format: plugins=(rails git textmate ruby lighthouse)
    # Add wisely, as too many plugins slow down shell startup.
    plugins=(
        git
        ros
        tmux
    )

    source $ZSH/oh-my-zsh.sh
else
    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi
    # Created by newuser for 5.8
    source ~/.powerlevel10k/powerlevel10k.zsh-theme
fi

# HISTORY
HISTSIZE=2795
SAVEHIST=2795
HISTFILE="$HOME/.history"
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt ALIASES

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]]    && source ~/.p10k.zsh
[[ -e ~/.profile ]]     && emulate sh -c 'source ~/.profile'
[[ -f ~/.aliases ]]     && source ~/.aliases

# Auto completions
if [[ -d ~/.zsh ]]; then
    # https://github.com/zsh-users/zsh-autosuggestions
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    fpath=(~/.zsh/completion $fpath)
    fpath=(~/.zsh/zsh-completions/src $fpath)
    autoload -Uz compinit && compinit -i
fi

# Default text editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# Color for man-pages
export MANPAGER="less -R --use-color -Dd+r -Du+b"
# 'bat' as the default pager for 'man'
if type bat > /dev/null; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export MANROFFOPT="-c"
fi

# Key binding
bindkey "^[[H"   beginning-of-line
bindkey "^[[F"   end-of-line
bindkey "^[[3~"  delete-char
# source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
source ~/.zkbd/keybindings
[[ -n ${key[Left]} ]]   && bindkey "${key[Left]}" backward-char
[[ -n ${key[Right]} ]]  && bindkey "${key[Right]}" forward-char
# etc.

# fuzzy finder
source ~/dotfiles/dfs/fzf/completion.zsh
source ~/dotfiles/dfs/fzf/key-bindings.zsh
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/dotfiles/dfs/fzf-tab/fzf-tab.plugin.zsh

# ROS - Robotic Operating System
if [ -d /opt/ros ]; then
    if [ -d /opt/ros/noetic ]; then
        source /opt/ros/noetic/setup.zsh
    elif [ -d /opt/ros2/foxy ]; then
        source /opt/ros2/foxy/setup.zsh
        export ROS_DOMAIN_ID=72
        export ROS_VERSION=2
        export ROS_PYTHON_VERSION=3
        export ROS_DISTRO=foxy
        export _colcon_cd_root=/opt/ros/foxy
        source /usr/share/colcon_cd/function/colcon_cd.sh
        source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh
    fi
    if [[ -f ~/WS/duc_ws/devel/setup.zsh ]]; then
        source ~/WS/duc_ws/devel/setup.zsh
    fi
    if [[ -f ~/WS/catkin_ws/devel/setup.zsh ]]; then
        source ~/WS/catkin_ws/devel/setup.zsh
    fi
fi

## NVIDIA
[[ -d /usr/lib/nvidia ]] && export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/nvidia
## libGLEW
# [[ -f /usr/lib/libGLEW.so ]] && export LD_PRELOAD=$LD_PRELOAD:/usr/lib/libGLEW.so

## python startup script
export PYTHONSTARTUP=~/.pythonrc

# Vale
export VALE_CONFIG_PATH=~/dotfiles/config/vale/.vale.ini
export VALE_STYLES_PATH=~/dotfiles/config/vale/styles
