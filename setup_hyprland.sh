#!/bin/bash

echo "Setting up Hyprland..."
sudo pacman -S --noconfirm $(cat packages_hyprland.txt)

if ! command -v paru &> /dev/null; then
    echo "paru not found, installing..."
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    (cd /tmp/paru && makepkg -si --noconfirm)
    rm -rf /tmp/paru
fi

paru -S --noconfirm $(cat packages_hyprland_aur.txt)
