return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  option = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = { "lua", "js", "python" },
      highlight = { enable = true },
      indent = { enable = true }
    })
  end
}
