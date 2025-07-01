-- All the configuration done in lua for neovim will be enabled from here
-- Things are being moved to lazy.nvim and other sub functions

-- Setup DAP
require 'dap_config'

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- Setup nvim-tree

-- require("telescope_config")
require('config.init')
