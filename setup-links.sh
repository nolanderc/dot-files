#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

function link_directory() {
    mkdir -p $1
    ln -sf $DIR/.vim/ftplugin/ $1/ftplugin
    ln -sf $DIR/.vim/ftdetect/ $1/ftdetect
    ln -sf $DIR/.vim/syntax/ $1/syntax
    ln -sf $DIR/.vim/indent/ $1/indent
}

# Create vim directory, and link configuration files
link_directory "$HOME/.vim/"
ln -sf $DIR/.vimrc ~/.vimrc

# Link TMUX configuration
ln -sf $DIR/.tmux.conf "$HOME/.tmux.conf"

# Link Kitty configuration
ln -sf $DIR/kitty/ "$HOME/.config/kitty"

# Link neovim configuration
ln -sf "$DIR/nvim/" "$HOME/.config/nvim"

