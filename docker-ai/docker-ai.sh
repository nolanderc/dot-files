#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(readlink -f "${BASH_SOURCE[0]}" | xargs dirname)" && pwd)"
DOCKERFILE="$SCRIPT_DIR/Dockerfile"
IMAGE="opencode:latest"
CHECKSUM_FILE="$SCRIPT_DIR/.dockerfile.sha256"
DOCKER_BUILD_CONTEXT="$SCRIPT_DIR"

current=$(sha256sum "$DOCKERFILE" | awk '{print $1}')

if [[ ! -f "$CHECKSUM_FILE" || $(cat "$CHECKSUM_FILE") != "$current" ]]; then
    echo "Building image $IMAGE..."
    sudo docker build \
        --build-arg USER_NAME="$(id -un)" \
        --build-arg USER_UID="$(id -u)" \
        --build-arg USER_GID="$(id -g)" \
        -t "$IMAGE" "$DOCKER_BUILD_CONTEXT"
    echo "$current" > "$CHECKSUM_FILE"
    echo "Build complete."
else
    echo "Dockerfile unchanged, skipping build."
fi

echo "Running image $IMAGE..."
sudo docker run --rm -it \
    -u "$(id -u):$(id -g)" \
    -e TERM="$TERM" \
    -e COLORTERM="$COLORTERM" \
    -e XDG_CONFIG_HOME="$HOME/.config" \
    -v /etc/terminfo:/etc/terminfo:ro \
    -v /lib/terminfo:/lib/terminfo:ro \
    -v "$PWD:$PWD" \
    -w "$PWD" \
    -v "$HOME/.config/opencode:$HOME/.config/opencode" \
    -v "$HOME/.local/share/opencode:$HOME/.local/share/opencode" \
    -v "$HOME/.local/state/opencode:$HOME/.local/state/opencode" \
    -v "$HOME/.cache/opencode:$HOME/.cache/opencode" \
    -v "$HOME/.gitconfig:$HOME/.gitconfig:ro" \
    "$IMAGE" \
    "$@"
