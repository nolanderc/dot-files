#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Link neovim configuration
ln -sf "$DIR/nvim/" "$HOME/.config/nvim"

# Link neovim configuration
ln -sf "$DIR/wezterm.lua" "$HOME/.wezterm.lua"

# Link tmux configuration
ln -sf "$DIR/.tmux.conf" "$HOME/.tmux.conf"
