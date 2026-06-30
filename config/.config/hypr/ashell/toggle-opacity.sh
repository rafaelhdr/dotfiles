#!/bin/bash
current=$(hyprctl -j getoption decoration:inactive_opacity | jq '.float')

case "$1" in
    status)
        jq -ne "$current >= 0.9" > /dev/null
        ;;
    *)
        if jq -ne "$current < 0.9" > /dev/null; then
            hyprctl eval "hl.config({ decoration = { inactive_opacity = 1.0 } })"
        else
            hyprctl eval "hl.config({ decoration = { inactive_opacity = 0.7 } })"
        fi
        ;;
esac
