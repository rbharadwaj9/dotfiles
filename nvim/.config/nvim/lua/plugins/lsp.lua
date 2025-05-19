return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = require("constants.lsp_servers").mason
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            { "neovim/nvim-lspconfig", config = function() require('lsp') end },
        },
        event = "VeryLazy",
    },
    {
      'j-hui/fidget.nvim',
      event = "LspAttach",
      config = true,
    },
}
