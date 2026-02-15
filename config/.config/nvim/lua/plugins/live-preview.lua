return {
  {
    "brianhuster/live-preview.nvim",
    config = function()
      require("live-preview").setup()
      vim.keymap.set(
        "n",
        "<leader>lp",
        function() vim.cmd("LivePreview start") end,
        { desc = "Start Live Preview" }
      )
    end,
    event = "VeryLazy",
  },
}
