#!/bin/bash

# Creating symbolic links
echo "Creating symbolic links..."
ln -sf ~/dotfiles/config/.zshrc ~/.zshrc
ln -sf ~/dotfiles/config/.config/nvim/ ~/.config/
ln -sf ~/dotfiles/config/.config/kitty/ ~/.config/

echo "Symbolic links created successfully."
