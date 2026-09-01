# rafaelhdr dotfiles

Personal dotfiles for Arch Linux.

# Quick Start

```
git clone git@github.com:rafaelhdr/dotfiles.git
cd dotfiles
bash setup.sh
```

You'll be asked whether to install Hyprland and related desktop packages.
Answer `n` for a headless/server install (just shell, neovim, and common
CLI tools) or `Y`/Enter for a full desktop install.

# macOS (ghostty)

`setup.sh` and the package lists are Arch-only, but the ghostty terminal
config is cross-platform. On macOS install ghostty and create the symlinks
directly (skip `setup.sh`):

```
brew install --cask ghostty
git clone git@github.com:rafaelhdr/dotfiles.git ~/dotfiles
cd ~/dotfiles
./create_symlinks.sh
```

`create_symlinks.sh` detects the OS (`uname`) and links `~/.config/ghostty/`,
pointing `os.conf` at the macOS include. Shared settings live in `config`;
Linux-only GTK bits (`gtk-custom-css`/`tabs.css`) stay in `linux.conf` and
macOS-only bits in `macos.conf`, so each platform loads only what it supports.
