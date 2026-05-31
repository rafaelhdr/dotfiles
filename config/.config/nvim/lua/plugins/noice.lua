return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
        notify = { enabled = false }, -- snacks handles notifications
        messages = { enabled = false }, -- keep messages at the bottom
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
        },
        cmdline = {
            enabled = true,
            view = "cmdline_popup",
        },
        views = {
            cmdline_popup = {
                position = { row = "40%", col = "50%" },
                size = { width = 60, height = "auto" },
                border = { style = "rounded" },
            },
            popupmenu = {
                relative = "editor",
                position = { row = "48%", col = "50%" },
                size = { width = 60, height = 10 },
                border = { style = "rounded" },
            },
        },
    },
}
