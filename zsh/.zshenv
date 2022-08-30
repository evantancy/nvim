# xdg
if [ -f "../okg/install" ]; then
   echo "Install script found"
   ../okg/install
else
   echo "Install script missing"
fi

cd $OKG_DACS_BASEDIR
if [[ $(ls -A) ]]; then
	#successfully inside container
	export XDG_CONFIG_HOME=$OKG_CONFIG_HOME
    export DYNAMIC_HOME="$OKG_HOME"
else
	# failed to ls inside container, operation not permitted
	export XDG_CONFIG_HOME="$HOME/.config" # default
    export DYNAMIC_HOME="$HOME"
    cd $HOME
fi
export XDG_DATA_HOME="$XDG_CONFIG_HOME/.local/share" # default
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/.cache" # default

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export BROWSER="firefox"
# prevent macOS from creating .zsh_sessions
SHELL_SESSIONS_DISABLE=1

# brew setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# maven
MAVEN_VER="3.5.4"
export M2_HOME=/usr/local/apache-maven/apache-maven-$MAVEN_VER
export M2=$M2_HOME/bin
export PATH=$M2:$PATH

# java setup
export JAVA_HOME=$(/usr/libexec/java_home -v1.8.0)
