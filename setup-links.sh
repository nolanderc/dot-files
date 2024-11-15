#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )"

function link() {
    if [[ -e "$2" ]]; then
        echo "skipping: $1 -> $2"
    else
        ln -sf "$(realpath "$1")" "$2"
    fi
}

mkdir -p "$HOME/.config/"
mkdir -p "$HOME/.local/bin/"

link "./nvim" "$HOME/.config/nvim"
link "./sway" "$HOME/.config/sway"
link "./foot" "$HOME/.config/foot"
link "./fish" "$HOME/.config/fish"

link "./scripts/wayland-cwd.sh" "$HOME/.local/bin/wayland-cwd.sh"

