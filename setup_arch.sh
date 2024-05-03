#!/bin/bash

echo "Setting up for Arch Linux..."
sudo pacman -Syu --noconfirm $(cat packages_common.txt)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
