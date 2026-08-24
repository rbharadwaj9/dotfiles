vim.keymap.set("n", "gl", "<Cmd>GBrowse!<CR>",  { desc = "Copy git URL (file)" })
vim.keymap.set("x", "gl", ":GBrowse!<CR>",      { desc = "Copy git URL (selection)" })
