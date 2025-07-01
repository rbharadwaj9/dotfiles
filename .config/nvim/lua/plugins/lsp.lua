return {
  {
    "mason-org/mason-lspconfig.nvim",
    config = function ()
      require("mason-lspconfig").setup{
        ensure_installed = require("constants.lsp_servers").mason,
        automatic_enable = false -- Since we have a separate lsp loading script, prevents duplicate LSPs
      };
    end,
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      { "neovim/nvim-lspconfig", },
      { "SmiteshP/nvim-navic", },
    },
    lazy = false,
  },
  {
    'j-hui/fidget.nvim',
    event = "LspAttach",
    config = function ()
      require("lsp")
    end
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
