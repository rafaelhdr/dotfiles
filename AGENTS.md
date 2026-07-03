# AGENTS.md

Personal dotfiles for Arch Linux (primary) and Debian/Ubuntu. Configs are
applied via symlinks; setup scripts install packages and create them.

## Repository structure

```
config/             source config files (symlinked into ~)
  .zshrc            zsh shell config
  .config/
    nvim/           neovim config (lazy.nvim, Lua)
    hypr/           hyprland, hyprlock, hyprpaper, mako, ashell (Lua + TOML) — see config/.config/hypr/AGENTS.md
    ghostty/        ghostty terminal config
    kitty/          kitty terminal config
packages_common.txt pacman packages installed on all systems
packages_hyprland.txt pacman packages for the Hyprland desktop
setup.sh            entry point: detects OS, runs symlinks + OS-specific setup
setup_arch.sh       arch-specific: pacman install + oh-my-zsh + hyprland setup
setup_debian.sh     debian/ubuntu-specific setup
setup_hyprland.sh   installs hyprland packages
create_symlinks.sh  creates symlinks from config/ into ~/
```

## Linting and formatting

CI runs on changes to `config/.config/nvim/` and `config/.config/hypr/`.

```bash
# Lua lint (luacheck)
luacheck config/.config/nvim/ config/.config/hypr/ --no-color --codes

# Lua format check (stylua)
stylua --check config/.config/nvim/ config/.config/hypr/

# Lua format apply
stylua config/.config/nvim/ config/.config/hypr/
```

Config files: `.luacheckrc` (max line length 140), `stylua.toml`.

## Making changes

- Edit files under `config/` — they are the source of truth (symlinked into ~).
- Lua files in `nvim/` and `hypr/` must pass luacheck and stylua before merging.
- To add a new symlink, update `create_symlinks.sh`.
- To add a system package, append it to `packages_common.txt` or
  `packages_hyprland.txt`.
- To add a neovim plugin, edit the relevant file under
  `config/.config/nvim/lua/plugins/`, then update `lazy-lock.json` (see below).

## Checking for updates

The only version-pinned artifact in this repo is `config/.config/nvim/lazy-lock.json`,
which records the exact commit for each neovim plugin managed by lazy.nvim.
Package lists have no version pins (pacman manages that at the system level).

To update neovim plugins and refresh the lockfile:

```bash
# Update all plugins headlessly (requires neovim installed)
nvim --headless "+Lazy! update" +qa

# Review the diff, then commit
git diff config/.config/nvim/lazy-lock.json
git add config/.config/nvim/lazy-lock.json
git commit -m "chore: update neovim plugin lockfile"
```

Run luacheck and stylua after updating if any plugin changes affect Lua config files.
