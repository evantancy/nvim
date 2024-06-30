# Turn off all beeps
unsetopt BEEP

# Load colors so we can access $fg and more.
autoload -U colors && colors

# setting `TERM = xterm-256color` in alacritty sometimes isn't being read, force
export TERM="xterm-256color"

case $(uname) in
"Linux")
    eval $(env TERM=xterm-256color dircolors)
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    # Bash's readline (.inputrc) functionality
    # Start typing + [Up-Arrow] - fuzzy find history forward
    if [[ -n "${terminfo[kcuu1]}" ]]; then
      autoload -U up-line-or-beginning-search
      zle -N up-line-or-beginning-search
      bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
      bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
      bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
    fi

    # Start typing + [Down-Arrow] - fuzzy find history backward
    if [[ -n "${terminfo[kcud1]}" ]]; then
      autoload -U down-line-or-beginning-search
      zle -N down-line-or-beginning-search
      bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
      bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
      bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
    fi

	;;
"Darwin")
    # homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # # dircolors is a GNU utility that's not on macOS by default. With this not
    # # being used on macOS it means zsh's complete menu won't have colors.
    # command -v gdircolors > /dev/null 2>&1 && eval "$(gdircolors -b)"
    # https://geoff.greer.fm/lscolors/
    export CLICOLOR=1
    export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd # Linux default colors

    # terminfo (above) doesn't work for macOS Monterey
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search
    bindkey -M emacs "^[[A" up-line-or-beginning-search
    bindkey -M viins "^[[A" up-line-or-beginning-search
    bindkey -M vicmd "^[[A" up-line-or-beginning-search

    autoload -U down-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey -M emacs "^[[B" down-line-or-beginning-search
    bindkey -M viins "^[[B" down-line-or-beginning-search
    bindkey -M vicmd "^[[B" down-line-or-beginning-search

    # gnu-tar
    export PATH="/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH"
	;;
esac

# Disable CTRL-s from freezing your terminal's output.
stty stop undef

# see https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/key-bindings.zsh

# [Ctrl-RightArrow] - move forward one word
bindkey -M emacs '^[^[[C' forward-word
bindkey -M viins '^[^[[C' forward-word
bindkey -M vicmd '^[^[[C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey -M emacs '^[^[[D' backward-word
bindkey -M viins '^[^[[D' backward-word
bindkey -M vicmd '^[^[[D' backward-word

# enable emacs
bindkey -e
# enable vim
# bindkey -v

# history settings
export HISTSIZE=100000 # maximum events for internal history
export SAVEHIST=$HISTSIZE # maximum events in history file
export HISTFILE="$HOME/.zsh_history"
setopt EXTENDED_HISTORY # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY # Share history between all sessions.
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS # Do not display a previously found event.
setopt HIST_IGNORE_SPACE # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS # Do not write a duplicate event to the history file.
setopt HIST_VERIFY # Do not execute immediately upon history expansion.
setopt HIST_REDUCE_BLANKS    # Remove unnecessary blank lines.
setopt INTERACTIVE_COMMENTS # Enable comments when working in an interactive shell.
setopt GLOB_DOTS # list all hidden files
setopt PROMPT_SUBST # ??

# Prompt. Using single quotes around the PROMPT is very important, otherwise
# the git branch will always be empty. Using single quotes delays the
# evaluation of the prompt. Also PROMPT is an alias to PS1.
git_prompt() {
    local branch="$(git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3)"
    local branch_truncated="${branch:0:30}"
    if (( ${#branch} > ${#branch_truncated} )); then
        branch="${branch_truncated}..."
    fi
    [ -n "${branch}" ] && echo "(${branch})"
}

# https://github.com/joshdick/dotfiles/blob/main/zshrc.symlink
git_info() {
  # Exit if not inside a Git repository
  ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

  # Git branch/tag, or name-rev if on detached head
  local GIT_LOCATION=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}

  local AHEAD="%{$fg[red]%}⇡NUM%{$reset_color%}"
  local BEHIND="%{$fg[cyan]%}⇣NUM%{$reset_color%}"
  local MERGING="%{$fg[magenta]%}⚡︎%{$reset_color%}"
  local UNTRACKED="%{$fg[red]%}●%{$reset_color%}"
  local MODIFIED="%{$fg[yellow]%}●%{$reset_color%}"
  local STAGED="%{$fg[green]%}●%{$reset_color%}"

  local -a DIVERGENCES
  local -a FLAGS

  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    DIVERGENCES+=( "${AHEAD//NUM/$NUM_AHEAD}" )
  fi

  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    DIVERGENCES+=( "${BEHIND//NUM/$NUM_BEHIND}" )
  fi

  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    FLAGS+=( "$MERGING" )
  fi

  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    FLAGS+=( "$UNTRACKED" )
  fi

  if ! git diff --quiet 2> /dev/null; then
    FLAGS+=( "$MODIFIED" )
  fi

  if ! git diff --cached --quiet 2> /dev/null; then
    FLAGS+=( "$STAGED" )
  fi

  local -a GIT_INFO
  GIT_INFO+=( "%{$fg[cyan]%}±" )
  [[ ${#DIVERGENCES[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)DIVERGENCES}" )
  [[ ${#FLAGS[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)FLAGS}" )
  GIT_INFO+=( "%{$fg[red]%}($GIT_LOCATION)%{$reset_color%}" )
  echo "${(j: :)GIT_INFO}"
}


git_prompt() {
    local branch="$(git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3-)"
    local branch_truncated="${branch:0:30}"
    if (( ${#branch} > ${#branch_truncated} )); then
        branch="${branch_truncated}..."
    fi

    [ -n "${branch}" ] && echo " (${branch})"
}
setopt PROMPT_SUBST
# Prompt. Using single quotes around the PROMPT is very important, otherwise
# the git branch will always be empty. Using single quotes delays the
# evaluation of the prompt. Also PROMPT is an alias to PS1.
PROMPT='%B%{$fg[cyan]%} %{$fg[blue]%}%~%{$fg[yellow]%}$(git_prompt)%{$reset_color%} %(?.$.%{$fg[red]%}$)%b '
# TODO: refactor current prompt because current, TOO SLOW DO NOT USE
# PROMPT='%{$fg[cyan]%}%* %{$fg[blue]%}%c%{$fg[yellow]%} $(git_info)%{$reset_color%} %(?.$.%{$fg[red]%}$)%b '


# zsh
source "$ZDOTDIR/zsh-functions"

# node version manager
export NVM_DIR="$HOME/.nvm"
export NVM_COMPLETION=false #significant slows zsh
export NVM_LAZY_LOAD=true
# export PATH=$PATH:$(npm config --global get prefix)/bin
# [ -f $NVIM_DIR/nvm.sh ] && source $NVM_DIR/nvm.sh

# plugins
zsh_add_plugin "Aloxaf/fzf-tab" # must be loaded FIRST!!! also unstable
zsh_add_plugin "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242,underline,bold'
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
ZSH_AUTOSUGGEST_MAX_BUFFER_SIZE=20
zsh_add_plugin "zdharma-continuum/fast-syntax-highlighting"
# zsh_add_plugin "lukechilds/zsh-nvm"
zsh_add_plugin "rupa/z"
zsh_add_plugin "sharkdp/fd"
FD_COMPLETION_DIR="$ZDOTDIR/plugins/fd/contrib/completion"
[ -d $FD_COMPLETION_DIR ] && fpath+=$FD_COMPLETION_DIR
zsh_add_plugin "conda-incubator/conda-zsh-completion"

# autocompletion
[ -d $ZDOTDIR/completions ] && fpath+="$ZDOTDIR/completions/"
autoload bashcompinit && bashcompinit
autoload -Uz compinit bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
# original zstyle setting before fixing speed
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# source: https://gist.github.com/magicdude4eva/2d4748f8ef3e6bf7b1591964c201c1ab
### Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
### Fix slowness of pastes
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# git completions
zstyle ':completion:*:*:git:*' script $ZDOTDIR/plugins/git/contrib/completion/git-completion.bash
export GIT_COMPLETION_CHECKOUT_NO_GUESS=1

######################## fzf-tab settings ####################################
# trigger continuous completion, useful for completion long paths
# default value, but we use '/' in branch names a lot
# zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':fzf-tab:*' continuous-trigger '\'
# show completion colors (like Bash's `set colored-completion-prefix on`)
zstyle ':completion:*' list-colors ${(@s.:.)LS_COLORS}
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort true

which pip &> /dev/null && eval "`pip completion --zsh`"
# case insensitive autocompletion
zstyle ':completion:*' matcher-list '' '+m:{a-zA-Z}={A-Za-z}' '+r:|[._-]=* r:|=*' '+l:|=* r:|=*'
# whether to show dirs ./ and ../
zstyle ':completion:*' special-dirs false
_comp_options+=(globdots)
compinit -i


# aliases
source $DOTFILES/.sh_aliases

# miniconda
# export PATH="$HOME/miniconda3/bin:$PATH"  # commented out by conda initialize
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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
conda activate base_env

# aliases ripped off Bash
# enable color support of ls and also add handy aliases
alias ls='ls --color=auto -hp'
alias dir='dir --color=auto -h'
alias vdir='vdir --color=auto -h'

alias grep='grep --color=auto --ignore-case'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# some more ls aliases
alias ll='ls -alFh'
alias la='ls -Aph'
alias l='ls -CFph'


# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_COMPLETION_TRIGGER='**'
export FZF_COMPLETION_OPTS='--multi --inline-info'
export FZF_DEFAULT_OPS='--multi --inline-info'
export FZF_DEFAULT_COMMAND="rg --files --hidden -g !.git/"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# TODO disabling CTRL-T for now since i use tmux alot
# bindkey -r '^T'

# tldr
[ -f ~/bin/tldr ] && compctl -k "($( tldr 2>/dev/null --list))" tldr

# sumo
export SUMO_HOME="/usr/share/sumo"

# foundry
export PATH="$PATH:$HOME/.foundry/bin"

# diff-so-fancy
export EDITOR="$(which nvim)"
export GPG_TTY=$(tty)

# rust
[ -f ~/.cargo/env ] && source ~/.cargo/env

# CUDA and cuDNN
export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH"
export CUDA_ROOT="/usr/local/cuda"

# ros stuff
[ -d /opt/ros ] && ROS_VER=$(ls /opt/ros)
ROS_SETUP_FILE=/opt/ros/$ROS_VER/setup.zsh
[ ! -z $ROS_VER ] && [ -f $ROS_SETUP_FILE ] && source $ROS_SETUP_FILE

gdf() {
	echo 'Commits that exist in '$1' but not in '$2':'
	git log --graph --pretty=format:'%Cred%h%Creset %s' --abbrev-commit $2..$1
	echo 'Commits that exist in '$2' but not in '$1':'
	git log --graph --pretty=format:'%Cred%h%Creset %s' --abbrev-commit $1..$2
}

curbranch() {
    git rev-parse --abbrev-ref HEAD
}

export PATH="$(python3 -m site --user-base)/bin:$PATH"
export PATH="$PATH:/Users/evan/.config/.foundry/bin"

# # add homebrew bin for postgresql@15
use_pg16(){
    export PATH=$PATH:$HOMEBREW_PREFIX/opt/postgresql@16/bin
}
use_pg15(){
    export PATH=$PATH:$HOMEBREW_PREFIX/opt/postgresql@15/bin
}
use_pg16

eval "$(direnv hook zsh)"
conda_remove() {
    for env in "$@"
    do
        conda env remove -n "$env"
    done
}

# # Start SSH agent
# if [ -z "$SSH_AUTH_SOCK" ]; then
#     # Check for a currently running instance of the agent
#     if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#         # Start a new instance of the agent
#         ssh-agent -s > "$HOME/.ssh/ssh-agent"
#     fi
#     if [[ -f "$HOME/.ssh/ssh-agent" ]]; then
#         eval "$(<"$HOME/.ssh/ssh-agent")" > /dev/null
#     fi
# fi
# set SSH_AUTH_SOCK env var to a fixed value
export SSH_AUTH_SOCK=~/.ssh/ssh-agent.sock

# test whether $SSH_AUTH_SOCK is valid
ssh-add -l 2>/dev/null >/dev/null

# if not valid, then start ssh-agent using $SSH_AUTH_SOCK
[ $? -ge 2 ] && ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null
