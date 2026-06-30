#!/bin/bash

echo "Setting up Hyprland..."
sudo pacman -S --noconfirm $(cat packages_hyprland.txt)
