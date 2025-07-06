vim.cmd("ca tn tabnew")
vim.cmd("ca tm tabmove")
vim.cmd("ca tc tabclose")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader= " "
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
