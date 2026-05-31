std = "max"
max_line_length = 140

files["config/.config/nvim/**"] = {
    globals = { "vim", "Snacks" },
}

files["config/.config/hypr/**"] = {
    globals = { "hl" },
}
