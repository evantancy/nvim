export LANG=en_US.UTF-8
# xdg
export _Z_DATA="$HOME/.z"
export XDG_CONFIG_HOME="$HOME/.config" # default
export XDG_DATA_HOME="$XDG_CONFIG_HOME/.local/share" # default
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/.cache"      # default

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
# prevent macOS from creating .zsh_sessions
SHELL_SESSIONS_DISABLE=1

# NOTE currently removed java and node setup
# # maven
# MAVEN_VER="3.5.4"
# export M2_HOME=/usr/local/apache-maven/apache-maven-$MAVEN_VER
# export M2=$M2_HOME/bin
# export PATH=$M2:$PATH
# # java setup
# export JAVA_HOME=$(/usr/libexec/java_home -v1.8.0)
# export PATH=$PATH:$(npm config --global get prefix)/bin

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
export DOTFILES="$HOME/.dotfiles"
[ ! -d "$HOME/bin" ] && mkdir -p "$HOME/bin"
[ ! -d "$HOME/.local/bin" ] && mkdir -p "$HOME/.local/bin"

export PATH=$PATH:~/bin
export PATH=$PATH:~/.local/bin

# golang
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin
