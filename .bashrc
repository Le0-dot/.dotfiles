#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

swap() {
    if [ $# -eq 2 ]
    then
	cp "$1" tmpfile
	mv "$2" "$1"
	mv tmpfile "$2"
    else
	echo "Needed 2 arguments"
    fi
}

ranger_non_recursive() {
    if [ -z "$RANGER_LEVEL" ]; then
        /usr/bin/ranger "$@"
    else
        exit
    fi
}

ranger_cd() {
    temp_file="$(mktemp -t "ranger.XXXXXXXXXX")"
    ranger_non_recursive --choosedir="$temp_file" -- "${@:-$PWD}"
    if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
        cd -- "$chosen_dir"
    fi
    rm -f -- "$temp_file"
}

##-----------------------------------------------------
## synth-shell-prompt.sh
if [ -f /home/le0/.config/synth-shell/synth-shell-prompt.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/le0/.config/synth-shell/synth-shell-prompt.sh
fi

##-----------------------------------------------------
## alias
if [ -f /home/le0/.config/synth-shell/alias.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/le0/.config/synth-shell/alias.sh
fi

alias ls='exa'
alias la='ls -a'
alias ll='ls -laF --time-style=long-iso'

alias tree='exa --tree'

alias cal='cal -m -3'

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'

alias vim='nvim'

alias ranger='ranger_cd'

shopt -s autocd

export PATH="$HOME/.local/bin/:$HOME/.cabal/bin/:$PATH"
export EDITOR=nvim
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
export GTK_THEME=Arc-Dark
export RANGER_LOAD_DEFAULT_RC=false

# swww variables
export SWWW_TRANSITION=simple
export SWWW_TRANSITION_STEP=2
export SWWW_TRANSITION_DURATION=3 # ignored with simple transition
export SWWW_TRANSITION_FPS=240
export SWWW_TRANSITION_ANGLE=45 # only for wipe and wave transitions
export SWWW_TRANSITION_POS=center # only for grow and outer transitions
export SWWW_INVERT_Y=false
export SWWW_TRANSITION_BEZIER=.54,0,.34,.99
export SWWW_TRANSITION_WAVE=20,20 # only for wave transition

bind '"\C-o":"ranger\C-m"'

# PS1='[\u@\h \W]\$ '

neofetch
