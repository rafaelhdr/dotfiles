#!/bin/bash

INCLUDE_HYPRLAND=${1:-true}
OS=$(uname -s)

# Symlink the ghostty config directory as individual files (not a directory
# symlink) so we can drop a per-machine os.conf symlink alongside them that
# points at the right platform include (linux.conf / macos.conf).
link_ghostty() {
    local os_conf=$1
    local src=~/dotfiles/config/.config/ghostty

    # Replace an old whole-directory symlink from previous versions of this repo.
    [ -L ~/.config/ghostty ] && rm ~/.config/ghostty
    mkdir -p ~/.config/ghostty

    ln -sf "$src/config"     ~/.config/ghostty/config
    ln -sf "$src/linux.conf" ~/.config/ghostty/linux.conf
    ln -sf "$src/macos.conf" ~/.config/ghostty/macos.conf
    ln -sf "$src/tabs.css"   ~/.config/ghostty/tabs.css
    ln -sf "$src/$os_conf"   ~/.config/ghostty/os.conf
}

# Creating symbolic links
echo "Creating symbolic links..."
mkdir -p ~/.config
ln -sf ~/dotfiles/config/.zshrc ~/.zshrc
ln -sfn ~/dotfiles/config/.config/nvim ~/.config/nvim

if [ "$OS" == "Darwin" ]; then
    link_ghostty macos.conf
elif [ "$INCLUDE_HYPRLAND" == "true" ]; then
    link_ghostty linux.conf

    mkdir -p ~/.local/share/nautilus-python/extensions
    ln -sf ~/dotfiles/config/.config/hypr/scripts/nautilus-set-wallpaper.py \
        ~/.local/share/nautilus-python/extensions/nautilus-set-wallpaper.py
fi

echo "Symbolic links created successfully."
