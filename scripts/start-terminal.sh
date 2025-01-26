#!/usr/bin/env bash

if [[ "$XDG_SESSION_TYPE" = "x11" ]]; then
    cd "$(xcwd)"
    uxterm && exit 0
    xterm && exit 0
    ghostty --working-directory=`xcwd` && exit 0
else
    wayland-cwd.sh foot
fi

