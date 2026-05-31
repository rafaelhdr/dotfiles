-- Luacheck configuration for dotfiles Lua (Neovim + Hyprland)
std = "max"

globals = {
    "vim",    -- Neovim Lua API
    "hl",     -- Hyprland Lua API
    "Snacks", -- snacks.nvim plugin global
}

-- Allow unused args (common in callback patterns, e.g. lsp handlers)
unused_args = false
