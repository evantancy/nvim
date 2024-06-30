#!/usr/bin/env bash

# remove x to disable printing of commands
set -euxo pipefail

BIN_DIR="$HOME/bin"
# change default shell to zsh
[ "$(echo $0)" != "zsh" ] && chsh -s $(command -v zsh)


# install homebrew
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed"
fi

if [ -f "brew_cmds.txt" ]; then
    while IFS= read -r cmd; do
        eval "$cmd"
    done < "brew_cmds.txt"
else
    echo "brew_cmds.txt not found"
    exit 1
fi

# vim-plug
VIMPLUG_DIR="$HOME/.local/share/nvim/site/autoload"
if ! [ -d "$VIMPLUG_DIR/plug.vim" ]; then
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/bin/fzf &&
	~/bin/fzf/install --key-bindings --completion --no-update-rc

# miniconda
mkdir -p ~/miniconda3
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

# macos settings
defaults write -g NSWindowShouldDragOnGesture -bool true
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
