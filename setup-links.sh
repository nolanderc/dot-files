#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

function link_directory() {
    mkdir -p $1
    ln -s $DIR/.vim/ftplugin/ $1/ftplugin
    ln -s $DIR/.vim/ftdetect/ $1/ftdetect
    ln -s $DIR/.vim/syntax/ $1/syntax
}

# Create vim directory, and link configuration files
link_directory "$HOME/.vim/"
ln -s $DIR/.vimrc ~/.vimrc

# Create neovim directory, and link configuration files
link_directory "$HOME/.config/nvim/"
ln -s $DIR/.vimrc ~/.config/nvim/init.vim

# Link TMUX configuration
ln -s $DIR/.tmux.conf ~/.tmux.conf



