# AGENTS.md

Personal dotfiles for Arch Linux and macOS. Configs are applied via symlinks;
setup scripts install packages and create them.

## Repository structure

```
config/             source config files (symlinked into ~)
  .zshrc            zsh shell config
  .config/
    nvim/           neovim config (lazy.nvim, Lua)
    hypr/           hyprland, hyprlock, hyprpaper, mako, ashell (Lua + TOML) — see config/.config/hypr/AGENTS.md
    ghostty/        ghostty terminal config (cross-platform: config = shared,
                    linux.conf = GTK-only, macos.conf = AppKit-only, loaded via
                    a per-machine os.conf symlink; tabs.css = Linux GTK styling)
packages_common.txt pacman packages installed always (server and desktop)
packages_desktop.txt pacman packages for GUI/desktop use (gitg, gnome-tweaks, proton-vpn-gtk-app)
packages_hyprland.txt pacman packages for the Hyprland desktop
packages_hyprland_aur.txt AUR packages for the Hyprland desktop (installed via paru)
packages_brew.txt   Homebrew formulae installed on macOS
setup.sh            entry point: dispatches on `uname` — Darwin runs symlinks + setup_macos.sh, Linux confirms Arch then prompts to include hyprland/desktop and runs symlinks + setup_arch.sh
setup_arch.sh       pacman install (common, + desktop/hyprland if requested) + oh-my-zsh
setup_macos.sh      installs Homebrew if missing, then packages_brew.txt + oh-my-zsh
setup_hyprland.sh   installs hyprland packages (pacman + AUR via paru)
create_symlinks.sh  creates symlinks from config/ into ~/ (desktop-only links gated by the same prompt); OS-aware via `uname` — on macOS it always links ghostty (os.conf -> macos.conf), on Linux ghostty is linked only for desktop installs (os.conf -> linux.conf)
```

On Linux, `setup.sh` asks "Include hyprland and related packages? [Y/n]" and
passes the answer (`true`/`false`) as `$1` to `create_symlinks.sh` and
`setup_arch.sh`. Answering `n` (used for headless servers) skips
`packages_desktop.txt`, `setup_hyprland.sh`, and the ghostty/Nautilus symlinks.
The macOS path takes no such flag — `create_symlinks.sh` links ghostty
unconditionally there.

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
- To add a system package, append it to `packages_common.txt` (installed
  always), `packages_desktop.txt` or `packages_hyprland.txt` (official repos,
  desktop-only), or `packages_hyprland_aur.txt` (AUR-only packages,
  desktop-only). macOS packages go in `packages_brew.txt` (Homebrew formulae
  only — casks are not installed by `setup_macos.sh`).
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
