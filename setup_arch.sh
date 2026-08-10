#!/bin/bash

INCLUDE_HYPRLAND=${1:-true}

echo "Setting up for Arch Linux..."
sudo pacman -Syu --noconfirm $(cat packages_common.txt)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

if ! command -v paru &> /dev/null; then
    echo "paru not found, installing..."
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    (cd /tmp/paru && makepkg -si --noconfirm)
    rm -rf /tmp/paru
fi

if [ "$INCLUDE_HYPRLAND" == "true" ]; then
    sudo pacman -S --noconfirm $(cat packages_desktop.txt)
    ./setup_hyprland.sh
fi
