return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "master",
  option = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = { "lua", "js", "python", "markdown", "markdown_inline" },
      highlight = { enable = true },
      indent = { enable = true }
    })
  end
}
