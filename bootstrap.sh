#!/usr/bin/env bash

# remove x to disable printing of commands
set -euxo pipefail

eval "$(/opt/homebrew/bin/brew shellenv)"

BIN_DIR="$HOME/bin"
# change default shell to zsh
[ "$(basename "$SHELL")" != "zsh" ] && chsh -s $(command -v zsh)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install homebrew
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed"
fi

# if [ -f "brew_cmds.txt" ]; then
#     while IFS= read -r cmd; do
#         eval "$cmd"
#     done < "brew_cmds.txt"
# else
#     echo "brew_cmds.txt not found"
#     exit 1
# fi

brew_packages=(
    eza
    awscli
    coreutils
    direnv
    go
    jq
    lazygit
    lazydocker
    medis
    ncdu
    pinentry-mac
    postgresql@16
    docker
    docker-compose
    pre-commit
    ruff
    spotify
    stats
    telnet
    universal-ctags
    xclip
    ykman
    openssh
    wget
    bat
    fd
    ripgrep
    git-delta
    git-filter-repo
    tmux
    # node@18
    fnm
    karabiner-elements
    koekeishiya/formulae/yabai
    # jordanbaird-ice
    commitizen
)
for package in "${brew_packages[@]}"; do
    brew install "$package"
done

# sketchybar
brew install lua
brew install switchaudio-osx
brew install nowplaying-cli
brew install --cask sf-symbols
brew install --cask font-sf-mono
brew install --cask font-sf-pro
brew install --cask font-hack-nerd-font
brew install --cask font-jetbrains-mono-nerd-font
brew install FelixKratz/formulae/sketchybar
brew services start sketchybar
(git clone https://github.com/FelixKratz/SbarLua.git ~/tmp/SbarLua && cd ~/tmp/SbarLua/ && make install)


brew_casks=(
    raycast
    alt-tab
    dbeaver-community
    iterm2
    keycastr
    another-redis-desktop-manager
    monodraw
    ngrok
    obsidian
    notion
    postman
    insomnia
    rectangle
    stats
    obsidian
)
for cask in "${brew_casks[@]}"; do
    brew install --cask "$cask"
done


# vim-plug
VIMPLUG_DIR="$HOME/.local/share/nvim/site/autoload"
if ! [ -d "$VIMPLUG_DIR/plug.vim" ]; then
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/bin/fzf &&
	~/bin/fzf/install --key-bindings --completion --no-update-rc

# miniconda
if [ ! -d "$HOME/miniconda3" ]; then
    mkdir -p ~/miniconda3
    curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o ~/miniconda3/miniconda.sh
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    rm -rf ~/miniconda3/miniconda.sh
fi

# macos settings
defaults write -g NSWindowShouldDragOnGesture -bool true
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
defaults write -g ApplePressAndHoldEnabled -bool false # disable accents popping up
defaults -currentHost write -globalDomain NSStatusItemSpacing 2
defaults -currentHost write -globalDomain NSStatusItemSelectionPadding -1
# echo "Changing macOS defaults..."
# defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# defaults write com.apple.spaces spans-displays -bool false
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock "mru-spaces" -bool "false"
# defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
# defaults write com.apple.LaunchServices LSQuarantine -bool false
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
# defaults write NSGlobalDomain KeyRepeat -int 1
# defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# defaults write NSGlobalDomain _HIHideMenuBar -bool true
# defaults write NSGlobalDomain AppleHighlightColor -string "0.65098 0.85490 0.58431"
# defaults write NSGlobalDomain AppleAccentColor -int 1
# defaults write com.apple.screencapture location -string "$HOME/Desktop"
# defaults write com.apple.screencapture disable-shadow -bool true
# defaults write com.apple.screencapture type -string "png"
# defaults write com.apple.finder DisableAllAnimations -bool true
# defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
# defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
# defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
# defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
# defaults write com.apple.Finder AppleShowAllFiles -bool true
# defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# defaults write com.apple.finder ShowStatusBar -bool false
# defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool YES
# defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
# defaults write com.apple.Safari IncludeDevelopMenu -bool true
# defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
# defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
# defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
# defaults write -g NSWindowShouldDragOnGesture YES


# run ssh setup
pkill ssh-agent
pkill gpg-agent
