#!/bin/bash

# Creating symbolic links
echo "Creating symbolic links..."
ln -sf ~/dotfiles/config/.zshrc ~/.zshrc
ln -sf ~/dotfiles/config/.config/nvim/ ~/.config/
ln -sf ~/dotfiles/config/.config/kitty/ ~/.config/
ln -sf ~/dotfiles/config/.config/ghostty/ ~/.config/

mkdir -p ~/.local/share/nautilus-python/extensions
ln -sf ~/dotfiles/config/.config/hypr/scripts/nautilus-set-wallpaper.py \
    ~/.local/share/nautilus-python/extensions/nautilus-set-wallpaper.py

echo "Symbolic links created successfully."
