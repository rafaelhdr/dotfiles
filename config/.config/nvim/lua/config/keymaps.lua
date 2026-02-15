-- stevearc/conform
vim.keymap.set("n", "<leader>fa", function()
  require("conform").format({ timeout_ms = 3000, lsp_fallback = false })
end)
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
