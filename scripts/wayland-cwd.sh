#!/usr/bin/env bash

for active in $(swaymsg -t get_tree --raw | jq 'recurse(.nodes[]) | select(.focused) | .pid' --raw-output); do
    for child in $(pgrep -P "$active" "$(basename "$SHELL")") $active; do
        cwd=$(readlink -e "/proc/$child/cwd")
        if [[ -n "$cwd" ]]; then
            cd "$cwd"
            break
        fi
    done
done

"$@"

