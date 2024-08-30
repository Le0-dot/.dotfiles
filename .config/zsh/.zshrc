ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d $ZINIT_HOME ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light atuinsh/atuin

zinit snippet OMZP::starship
zinit snippet OMZP::zoxide
zinit snippet OMZP::direnv
zinit snippet OMZP::asdf
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found


autoload -U compinit && compinit

zinit cdreplay -q

bindkey -e

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'


alias ls='eza'
alias ll='ls -laF --time-style=long-iso'
alias tree='exa --tree'

alias cal='cal -m -3'

alias v='nvim'

alias docker-prune='docker system prune'
