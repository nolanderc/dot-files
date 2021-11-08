#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Link TMUX configuration
ln -sf $DIR/.tmux.conf "$HOME/.tmux.conf"

# Link Kitty configuration
ln -sf $DIR/kitty/ "$HOME/.config/kitty"

# Link neovim configuration
ln -sf "$DIR/nvim/" "$HOME/.config/nvim"

