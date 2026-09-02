local languages = { "lua", "javascript", "python", "markdown", "markdown_inline", "yaml" }

-- filetypes to turn treesitter highlighting/indenting on for
-- (markdown_inline is an injected parser, it has no filetype of its own)
local filetypes = { "lua", "javascript", "python", "markdown", "yaml" }

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- the main branch does not support lazy-loading
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install(languages)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetypes,
            callback = function()
                vim.treesitter.start()
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
