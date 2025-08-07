return {
  "olimorris/codecompanion.nvim",
  opts = {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    vim.keymap.set("n", "<leader>cc", '<cmd>CodeCompanionChat Toggle<CR>', {})

    require("codecompanion").setup({
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "cmd:op read op://home/rafaelhdr/Documents/claude.txt --no-newline",
            },
          })
        end,
      },
    })
  end,
}
