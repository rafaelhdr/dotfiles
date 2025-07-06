return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      debug = true,
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.black.with({
          extra_args = { "--line-length", "120", "--indent-size", "4" },
        }),
        null_ls.builtins.formatting.isort,
      },
    })

    vim.keymap.set("n", "<leader>fa", vim.lsp.buf.format, {})
  end,
}
