return {
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = require("constants.lsp_servers").mason,
        automatic_enable = false -- Since we have a separate lsp loading script, prevents duplicate LSPs
      };
    end,
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
    },
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = { "mason-org/mason-lspconfig.nvim", "saghen/blink.cmp", "SmiteshP/nvim-navic", },
    config = function ()
      require("lsp")
    end

  },
  {
    'j-hui/fidget.nvim',
    opts = {},
    event = "LspAttach",
  },
  -- SchemaStore catalog for JSON and YAML.  Explicitly enabled in LSP config.
  {
    "b0o/SchemaStore.nvim",
    ft = { "json", "yaml" },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
