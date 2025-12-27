#!/usr/bin/env bash

enable_monitor() {
    local name=$1
    local mode=$2
    local pos=$3
    local scale=$4
    local transform=$5
    hyprctl keyword monitor "${name},${mode},${pos},${scale},${transform}"
}

connected=$(hyprctl monitors -j | jq -r '.[].name')

if echo "$connected" | grep -q "^DP-3$"; then
    enable_monitor "DP-3" "3840x2160@60" "0x0" "1" "0"
    hyprctl keyword monitor "eDP-1,disable"
else
    enable_monitor "eDP-1" "1920x1200@60" "3840x0" "1" "0"
    hyprctl keyword monitor "DP-3,disable"
fi
