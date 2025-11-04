#!/usr/bin/env bash

set -eou pipefail
set -x

DOTDIR="$(dirname "${BASH_SOURCE[0]}")"
cd "$DOTDIR"

# Setup configuration
./setup-links.sh
dconf load / < config/dconf.ini

# Install packages
packages=(
	build-essential
	git
	zoxide
	direnv
	curl
	wget
	fish
    gh
    ripgrep
    tmux
    foot
    foot-themes
    wl-clipboard
)
sudo apt install -y "${packages[@]}"

# Activate default shell
fish_path=`which fish`
if [ -n "$fish_path" ]; then
	sudo chsh -s "$fish_path" "$USER"
fi

# Install other tools and binaries
mkdir -p ~/.local/bin/
cd ~/.local/bin

nvim_version="0.11.4"
nvim_name="nvim-linux-$nvim_version"
if ! [ -d "$HOME/.local/bin/$nvim_name" ]; then
    nvim_tar="/tmp/$nvim_name.tar.gz"
    wget "https://github.com/neovim/neovim/releases/download/v$nvim_version/nvim-linux-x86_64.tar.gz" -O "$nvim_tar"
    mkdir "$nvim_name"
    tar xf "$nvim_tar" --strip-components=1 -C "$nvim_name"
    rm "$nvim_tar"
    ln --force --symbolic "./$nvim_name/bin/nvim" ./nvim
    ln --force --symbolic "./$nvim_name/bin/nvim" ./vim
fi

if ! [ -d "$HOME/.cargo" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

if ! gh auth status; then
    gh auth login --web --git-protocol https --hostname github.com
fi

if ! [ -d "$HOME/.local/share/comic-code" ] && gh repo view comic-code &>/dev/null; then
    gh repo clone comic-code "$HOME/.local/share/comic-code"
fi

mkdir -p "$HOME/.local/share/fonts"
ln --force --symbolic "$HOME/.local/share/comic-code/Comic Code/NERD/"*.otf "$HOME/.local/share/fonts/"
if ! fc-cache "$HOME/.local/share/fonts"; then
    echo "could not rebuild font cache"
fi

if ! command -v jj; then
    cargo install --locked --bin jj jj-cli
fi
