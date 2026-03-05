-- stevearc/conform
vim.keymap.set("n", "<leader>fa", function()
  require("conform").format({ timeout_ms = 3000, lsp_fallback = false })
end)
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

-- lsp
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gD", function()
  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, ctx)
    if err or not result or vim.tbl_isempty(result) then
      return
    end

    vim.cmd("tabnew")
    vim.lsp.util.jump_to_location(result[1], "utf-8")
  end)
end, { desc = "Go to definition (new tab)" })
