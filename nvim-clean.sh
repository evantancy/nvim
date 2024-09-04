#!/usr/bin/env bash
source ./shared_vars
echo $XDG_CACHE_HOME
echo $XDG_CONFIG_HOME
echo $XDG_DATA_HOME

[ -d $XDG_CACHE_HOME/nvim ] && rm -rf $XDG_CACHE_HOME/nvim
[ -d $XDG_DATA_HOME/nvim ] && rm -rf $XDG_DATA_HOME/nvim
[ -d $XDG_CONFIG_HOME/nvim ] && rm -rf $XDG_CONFIG_HOME/nvim

echo "Neovim cache, data, and configuration directories have been cleaned."
