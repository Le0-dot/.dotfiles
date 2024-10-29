typeset -U path PATH
path=(~/.local/bin ~/.cabal/bin ~/.ghcup/bin ~/go/bin $path)
export PATH

export EDITOR=nvim
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
export ZOXIDE_CMD_OVERRIDE=cd
