typeset -U path PATH
path=(~/.local/bin ~/.cabal/bin ~/.ghcup/bin ~/go/bin $path)
export PATH

export EDITOR=nvim
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
export ZOXIDE_CMD_OVERRIDE=cd

export VCPKG_ROOT=$HOME/.local/share/vcpkg
export CMAKE_TOOLCHAIN_FILE=${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake
