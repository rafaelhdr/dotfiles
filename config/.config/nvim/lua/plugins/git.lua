return {
  "f-person/git-blame.nvim",
  event = "VeryLazy",
  opts = {
    enabled = false,
    date_format = "%Y-%m-%d %H:%M:%S",
  },
  config = function(_, opts)
    vim.keymap.set("n", "<leader>gb", "<cmd>GitBlameToggle<CR>", { desc = "Toggle Git Blame" })

    require("gitblame").setup(opts)
  end,
}
