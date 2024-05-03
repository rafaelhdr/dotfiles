#!/bin/bash

echo "Detecting operating system..."
OS=$(grep ^ID= /etc/os-release | cut -d= -f2)

./create_symlinks.sh

if [ "$OS" == "arch" ]; then
    echo "Arch Linux detected."
    ./setup_arch.sh
elif [ "$OS" == "debian" ]; then
    echo "Debian detected."
    ./setup_debian.sh
else
    echo "Unsupported OS."
    exit 1
fi
