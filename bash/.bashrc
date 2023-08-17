# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoredups:erasedups
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=100000
export HISTFILESIZE=100000

# https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
shopt -s histappend       # append to the history file, don't overwrite it
shopt -s autocd           # automatically cd into dirs
shopt -s cdspell dirspell # correct minor spelling errors
shopt -s checkwinsize     # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s globstar         # If set, the pattern "**" used in a pathname expansion context will match all files and zero or more directories and subdirectories.
shopt -s cmdhist          # try to save multiline commands

if [ "$TERM" = "xterm-256color" ]; then
	PROMPT_COMMAND='echo -en "\033]0;Terminal\a"' # set fixed title for terminal win
fi
# export PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

parse_git_branch() {
	git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# TODO trying to fix slow prompt
# if [ "$color_prompt" = yes ]; then
# 	# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# 	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\] \[\033[01;34m\]\W\[\e[91m\]$(parse_git_branch)\[\033[00m\]$ '
# else
# 	# PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# 	PS1='${debian_chroot:+($debian_chroot)}\u \W$(parse_git_branch)$ '
# fi
unset color_prompt force_color_prompt

# set custom prompt with 2 chars per directory
# TODO: enable color
# PS1='$(echo $(dirname \w) | sed -e "s;\(/..\)[^/]*;\1;g")/$(basename \w) $ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
	# line below hides hostname, ONLY ENABLE ONE
	# PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	# PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u: \w\a\]$PS1"
	;;
*) ;;
esac

# enable color support (default)
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto -h'
	alias dir='dir --color=auto -h'
	alias vdir='vdir --color=auto -h'

	alias grep='grep --color=auto --ignore-case'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

export XDG_CONFIG_HOME="$HOME/.config" # default
export BASHDOTDIR="$XDG_CONFIG_HOME/bash"
export DOTFILES="$HOME/.dotfiles"
if [ -f $DOTFILES/.sh_aliases ]; then
	. $DOTFILES/.sh_aliases
fi

COMPLETIONS_DIR="$BASHDOTDIR/.bash_completion.d"
if [ -d $COMPLETIONS_DIR ]; then
	for completion in "$COMPLETIONS_DIR"/*; do
		. $completion
	done
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	elif [ -f /usr/local/etc/bash_completion ]; then
		# macOS completion
		. /usr/local/etc/bash_completion
	fi
fi

# bind 'TAB:menu-complete'

# SSH SETTINGS
# eval $(keychain --eval --quiet --agents ssh ~/.ssh/ubuntu1804-DLWS)

# added by Miniconda3 installer
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/evan/miniconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
	eval "$__conda_setup"
else
	if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
		. "$HOME/miniconda3/etc/profile.d/conda.sh"
	else
		export PATH="$HOME/miniconda3/bin:$PATH"
	fi
fi
unset __conda_setup
# <<< conda initialize <<<

# BEGIN USER BASH SETTINGS - ANSIBLE MANAGED BLOCK
# HISTTIMEFORMAT="%D @ %T "
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin
# write Bash history across multiple shells
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# max num folders in path
#export PROMPT_DIRTRIM=2
# END USER BASH SETTINGS - ANSIBLE MANAGED BLOCK

source $BASHDOTDIR/bash-functions

# BEGIN FZF SETTINGS - ANSIBLE MANAGED BLOCK
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='**'
export FZF_COMPLETION_OPTS='--inline-info'
export FZF_DEFAULT_OPS=' --inline-info'
bash_add_plugin "lincheney/fzf-tab-completion"
# manually add file because of nested 'bash' folder & difference in name of script and plugin
bash_add_file "plugins/fzf-tab-completion/bash/fzf-bash-completion.sh"
bind -x '"\t": fzf_bash_completion'
# END FZF SETTINGS - ANSIBLE MANAGED BLOCK

# BEGIN TLDR SETTINGS - ANSIBLE MANAGED BLOCK
complete -W "$(tldr 2>/dev/null --list)" tldr
# END TLDR SETTINGS - ANSIBLE MANAGED BLOCK

# node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
# # NVM LAZY LOADING
# # https://www.growingwiththeweb.com/2018/01/slow-nvm-init.html
# if [ -s "$HOME/.nvm/nvm.sh" ]; then
# 	export NVM_DIR="$HOME/.nvm"
# 	[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
# 	alias nvm='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && nvm'
# 	alias node='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && node'
# 	alias npm='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && npm'
# fi
#
# # Defer initialization of nvm until nvm, node or a node-dependent command is
# # run. Ensure this block is only run once if .bashrc gets sourced multiple times
# # by checking whether __init_nvm is a function.
# if [ -s "$HOME/.nvm/nvm.sh" ] && [ ! "$(type -t __init_nvm)" = function ]; then
# 	export NVM_DIR="$HOME/.nvm"
# 	[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
# 	declare -a __node_commands=('nvm' 'node' 'npm' 'yarn' 'gulp' 'grunt' 'webpack')
# 	function __init_nvm() {
# 		for i in "${__node_commands[@]}"; do unalias $i; done
# 		. "$NVM_DIR"/nvm.sh
# 		unset __node_commands
# 		unset -f __init_nvm
# 	}
# 	for i in "${__node_commands[@]}"; do alias $i='__init_nvm && '$i; done
# fi

# sumo
export SUMO_HOME="/usr/share/sumo"

# foundry
export PATH="$PATH:/home/evan/.foundry/bin"

# rust
. "$HOME/.cargo/env"

export EDITOR="nvim"
export GPG_TTY=$(tty)
