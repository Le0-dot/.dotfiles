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

# starship
eval "$(starship init bash)"

# zoxide
eval "$(zoxide init bash)"

# pacman suggestions for commands
source /usr/share/doc/pkgfile/command-not-found.bash

# fzf
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# source asdf
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

# source direnv
eval "$(direnv hook bash)"


alias ls='exa'
alias la='ls -a'
alias ll='ls -laF --time-style=long-iso'

alias cd='z'

alias tree='exa --tree'

alias cal='cal -m -3'

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gd='git diff'
alias gl='git log'

alias vim='nvim'

alias ranger='ranger_cd'

shopt -s autocd

export PATH="$HOME/.local/bin/:$HOME/.cabal/bin/:$HOME/.ghcup/bin/:$PATH"
export EDITOR=nvim
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
export GTK_THEME=Arc-Dark
export RANGER_LOAD_DEFAULT_RC=false

export VCPKG_ROOT=$HOME/.local/share/vcpkg
export CMAKE_TOOLCHAIN_FILE=${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake

neofetch
