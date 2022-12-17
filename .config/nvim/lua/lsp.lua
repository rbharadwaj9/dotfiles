-- Native LSP Setup
-- This file aims to configure everything that nvim needs to connect and provide 
-- information as an LSP client. 
--
-- The user will still be required to install the appropriate Language Server 
-- on their own. See https://langserver.org
local capabilities = require('completion')

require('lspconfig').gopls.setup{
    capabilities = capabilities,

    on_attach = function()
        -- Gets run inside every buffer that gets attached
        -- buffer=0 is current buffer
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})

        vim.keymap.set("n", "<leader>aj", vim.diagnostic.goto_next, {buffer=0})
        vim.keymap.set("n", "<leader>ak", vim.diagnostic.goto_prev, {buffer=0})

        -- Bulk Rename --
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {buffer=0})
    end,
}
