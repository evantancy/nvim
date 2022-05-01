# Load colors so we can access $fg and more.
autoload -U colors && colors
# Disable CTRL-s from freezing your terminal's output.
stty stop undef

setopt interactive_comments # Enable comments when working in an interactive shell.

# Prompt. Using single quotes around the PROMPT is very important, otherwise
# the git branch will always be empty. Using single quotes delays the
# evaluation of the prompt. Also PROMPT is an alias to PS1.
git_prompt() {
    local branch="$(git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3)"
    local branch_truncated="${branch:0:30}"
    if (( ${#branch} > ${#branch_truncated} )); then
        branch="${branch_truncated}..."
    fi

    [ -n "${branch}" ] && echo "${branch}"
}
setopt PROMPT_SUBST
# from nickjj
# PROMPT='%B%{$fg[green]%}%n@%{$fg[green]%}%M %{$fg[blue]%}%~%{$fg[yellow]%}$(git_prompt)%{$reset_color%} %(?.$.%{$fg[red]%}$)%b '
PROMPT='%B%{$fg[blue]%}%c%{$fg[magenta]%}(%{$reset_color%}%{$fg[red]%}$(git_prompt)%{$fg[magenta]%})%{$reset_color%}%(?.$.%{$fg[red]%}$)%b '

export DOTFILES="$HOME/.dotfiles"
export PATH=$PATH:~/bin
export PATH=$PATH:~/.local/bin

# xdg
export XDG_CONFIG_HOME="$HOME/.config" # default
export XDG_DATA_HOME="$XDG_CONFIG_HOME/.local/share" # default
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/.cache" # default

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
source "$ZDOTDIR/zsh-functions"

# node version manager
export NVM_DIR="$HOME/.nvm"
export NVM_COMPLETION=false #significant slows zsh
export NVM_LAZY_LOAD=false

# plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zdharma-continuum/fast-syntax-highlighting"
zsh_add_plugin "Aloxaf/fzf-tab"
zsh_add_plugin "lukechilds/zsh-nvm"
zsh_add_plugin "changyuheng/fz"

[ -d $ZDOTDIR/completions ] && fpath+="$ZDOTDIR/completions/"
# autocompletion
autoload bashcompinit && bashcompinit
autoload -Uz compinit

eval "`pip completion --zsh`"
# case insensitive autocompletion
zstyle ':completion:*' matcher-list '' '+m:{a-zA-Z}={A-Za-z}' '+r:|[._-]=* r:|=*' '+l:|=* r:|=*'
_comp_options+=(globdots)
# zstyle ':completion:*' menu select=2
# zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
# zstyle ':completion:*' format 'Completing %d'
# zstyle ':completion:*' group-name ''

# dircolors is a GNU utility that's not on macOS by default. With this not
# being used on macOS it means zsh's complete menu won't have colors.
command -v dircolors > /dev/null 2>&1 && eval "$(dircolors -b)"

# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle ':completion:*' use-compctl false
# zstyle ':completion:*' verbose true
#
compinit -i

# history settings
export HISTSIZE=100000 # maximum events for internal history
export SAVEHIST=$HISTSIZE # maximum events in history file
export HISTFILE="$HOME/.zsh_history"
setopt EXTENDED_HISTORY # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS # Do not display a previously found event.
setopt HIST_IGNORE_SPACE # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS # Do not write a duplicate event to the history file.
setopt HIST_VERIFY # Do not execute immediately upon history expansion.
setopt HIST_REDUCE_BLANKS    # Remove unnecessary blank lines.

# aliases
source $DOTFILES/.sh_aliases

# dircolors and aliases ripped off Bash
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto -h'
	alias dir='dir --color=auto -h'
	alias vdir='vdir --color=auto -h'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi
# some more ls aliases
alias ll='ls -alF -h'
alias la='ls -A -h'
alias l='ls -CF -h'

# miniconda
export PATH="$HOME/miniconda3/bin:$PATH"
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/evan/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/evan/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/evan/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/evan/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# golang
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_COMPLETION_TRIGGER='**'
export FZF_COMPLETION_OPTS='--multi --inline-info'
export FZF_DEFAULT_OPS='--multi --inline-info'

# z - jump around
source $DOTFILES/bash/.bash_completion.d/z.sh

# tldr
[ -f ~/bin/tldr ] && compctl -k "($( tldr 2>/dev/null --list))" tldr

# sumo
export SUMO_HOME="/usr/share/sumo"

# foundry
export PATH="$PATH:$HOME/.foundry/bin"

# diff-so-fancy
export PATH="$PATH:$HOME/bin/diff-so-fancy"
export EDITOR="nvim"
export GPG_TTY=$(tty)
