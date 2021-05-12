#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Create neovim directory, and link configuration files
mkdir -p ~/.vim/
ln -s $DIR/.vimrc ~/.vimrc
ln -s $DIR/.vim/ftplugin/ ~/.vim/ftplugin

mkdir -p ~/.config/nvim/
ln -s $DIR/.vimrc ~/.config/nvim/init.vim
ln -s $DIR/.vim/ftplugin/ ~/.config/nvim/ftplugin

# Link TMUX configuration
ln -s $DIR/.tmux.conf ~/.tmux.conf



