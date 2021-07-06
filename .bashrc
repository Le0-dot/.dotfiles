#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

calc(){ awk "BEGIN { print "$*" }"; }

function swap {
    if [ $# -eq 2 ]
    then
	cp "$1" tmpfile
	mv "$2" "$1"
	mv tmpfile "$2"
    else
	echo "Needed 2 arguments"
    fi
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

alias gs='git status'
alias ga='git add'
alias gc='git commit'

shopt -s autocd

export PATH="$HOME/.local/bin/:$PATH"

# PS1='[\u@\h \W]\$ '

neofetch
