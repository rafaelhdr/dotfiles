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
      strategies = {
        chat = {
          model = "sonnet-4.5",
          adapter = "anthropic",
        },
      },
      adapters = {
        http = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = "cmd:cat /home/rafaelhdr/Documents/claude.txt",
              },
            })
          end,
        },
      },
    })
  end,
}
