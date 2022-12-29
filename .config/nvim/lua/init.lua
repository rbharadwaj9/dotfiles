-- All the configuration done in lua for neovim will be enabled from here

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Setup LSP and Completion (done inside LSP)
require 'lsp'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Setup nvim-tree
require("nvim-tree").setup({
    renderer = {
        icons = {
            show = {
                file = false,
                folder = false,
                folder_arrow = false,
            }
        }
    },
})
