# rafaelhdr dotfiles

Personal dotfiles for Arch Linux and macOS.

# Quick Start

```
git clone git@github.com:rafaelhdr/dotfiles.git
cd dotfiles
bash setup.sh
```

You'll be asked whether to install Hyprland and related desktop packages.
Answer `n` for a headless/server install (just shell, neovim, and common
CLI tools) or `Y`/Enter for a full desktop install.

# macOS

```
git clone git@github.com:rafaelhdr/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash setup.sh
```

`setup.sh` detects macOS (`uname`) and runs `setup_macos.sh`, which installs
Homebrew if it's missing, installs the formulae in `packages_brew.txt` (nvm,
neovim, node, ripgrep, ...) and oh-my-zsh. The Arch package lists and the
hyprland prompt are skipped.

Ghostty is not in `packages_brew.txt` because it's a cask; install it with
`brew install --cask ghostty`.

`create_symlinks.sh` links `~/.config/ghostty/`, pointing `os.conf` at the
macOS include. Shared settings live in `config`; Linux-only GTK bits
(`gtk-custom-css`/`tabs.css`) stay in `linux.conf` and macOS-only bits in
`macos.conf`, so each platform loads only what it supports.
