# brew setup
eval "$(/opt/homebrew/bin/brew shellenv)"
export LANG=en_US.UTF-8

# xdg
BASEDIR="$DACS"
CONFIG_HOME="$BASEDIR/Documents/.config"
DOCUMENTS="$BASEDIR/Documents"
if [[ $(ls -A $DOCUMENTS) ]]; then
  # successfully inside container
  export Z_DATA="$DOCUMENTS/_z"
  # export XDG_CONFIG_HOME=$CONFIG_HOME
  # export DYNAMIC_HOME="$DOCUMENTS"
  # for zsh stuff
  export TMPPREFIX="$DOCUMENTS/tmp/zsh"
  # mvnd settings
  export MVND_MIN_THREADS=3
  export MVND_THREADS=9
  export MVND_DAEMON_STORAGE="$DOCUMENTS/.m2/registry/"
else
  export Z_DATA="$HOME/_z"
  # failed to ls inside container, operation not permitted
  export XDG_CONFIG_HOME="$HOME/.config" # default
  export DYNAMIC_HOME="$HOME"
  cd $HOME
fi

export XDG_CONFIG_HOME="$HOME/.config" # default
export DYNAMIC_HOME="$HOME"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/.local/share" # default
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/.cache"      # default

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export BROWSER="firefox"
# prevent macOS from creating .zsh_sessions
SHELL_SESSIONS_DISABLE=1

# maven
MAVEN_VER="3.5.4"
export M2_HOME=/usr/local/apache-maven/apache-maven-$MAVEN_VER
export M2=$M2_HOME/bin
export PATH=$M2:$PATH

# java setup
export JAVA_HOME=$(/usr/libexec/java_home -v1.8.0)
export PATH=$PATH:$(npm config --global get prefix)/bin
export WINEPREFIX=~/Games/battle-net

# clean and reinstall symlinks according to env
# cd $DYNAMIC_HOME/.dotfiles/
# ./install
# cd $DYNAMIC_HOME
