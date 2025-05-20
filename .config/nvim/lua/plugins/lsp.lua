return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = require("constants.lsp_servers").mason
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            { "neovim/nvim-lspconfig", },
        },
        lazy = false,
    },
    {
      'j-hui/fidget.nvim',
      event = "LspAttach",
      config = function ()
            require('lsp')
      end,
    },
}
