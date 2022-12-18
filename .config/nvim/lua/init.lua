-- All the configuration done in lua for neovim will be enabled from here

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Setup LSP and Completion (done inside LSP)
require 'lsp'
