#!/bin/bash

echo "Detecting operating system..."
OS=$(grep ^ID= /etc/os-release | cut -d= -f2)

if [ "$OS" != "arch" ]; then
    echo "Only Arch Linux is supported."
    exit 1
fi

read -p "Include hyprland and related packages? [Y/n] " answer
case "$answer" in
    [nN]*) INCLUDE_HYPRLAND=false ;;
    *) INCLUDE_HYPRLAND=true ;;
esac

./create_symlinks.sh "$INCLUDE_HYPRLAND"
./setup_arch.sh "$INCLUDE_HYPRLAND"

# Set zsh as default shell
chsh -s `which zsh`
