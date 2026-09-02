#!/bin/bash

echo "Detecting operating system..."
OS=$(uname -s)

if [ "$OS" == "Darwin" ]; then
    ./create_symlinks.sh
    ./setup_macos.sh
elif [ "$OS" == "Linux" ]; then
    DISTRO=$(grep ^ID= /etc/os-release | cut -d= -f2)
    if [ "$DISTRO" != "arch" ]; then
        echo "On Linux, only Arch is supported."
        exit 1
    fi

    read -p "Include hyprland and related packages? [Y/n] " answer
    case "$answer" in
        [nN]*) INCLUDE_HYPRLAND=false ;;
        *) INCLUDE_HYPRLAND=true ;;
    esac

    ./create_symlinks.sh "$INCLUDE_HYPRLAND"
    ./setup_arch.sh "$INCLUDE_HYPRLAND"
else
    echo "Only Arch Linux and macOS are supported."
    exit 1
fi

# Set zsh as default shell
chsh -s `which zsh`
