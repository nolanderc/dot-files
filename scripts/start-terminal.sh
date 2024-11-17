#!/usr/bin/env bash

if [[ "$XDG_SESSION_TYPE" = "x11" ]]; then
    cd "$(xcwd)"
    uxterm
else
    wayland-cwd.sh foot
fi

