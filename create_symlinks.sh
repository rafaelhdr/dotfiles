#!/bin/bash

# Creating necessary directories
mkdir -p ~/.config/nvim

# Creating symbolic links
echo "Creating symbolic links..."
ln -sf ~/dotfiles/config/.zshrc ~/.zshrc
ln -sf ~/dotfiles/config/.config/nvim/init.vim ~/.config/nvim/init.vim

echo "Symbolic links created successfully."
