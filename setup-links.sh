#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )"

function link() {
    if [[ -e "$2" ]]; then
        echo "skipping: $1 -> $2"
    else
        echo "linking:  $1 -> $2"
        ln -sf "$(realpath "$1")" "$2"
    fi
}

mkdir -p "$HOME/.config/"
mkdir -p "$HOME/.local/bin/"

link "./nvim" "$HOME/.config/nvim"
link "./sway" "$HOME/.config/sway"
link "./foot" "$HOME/.config/foot"
link "./fish" "$HOME/.config/fish"
link "./i3" "$HOME/.config/i3"

link "./scripts/wayland-cwd.sh" "$HOME/.local/bin/wayland-cwd.sh"
link "./scripts/start-terminal.sh" "$HOME/.local/bin/start-terminal.sh"
link "./Xresources" "$HOME/.Xresources"

