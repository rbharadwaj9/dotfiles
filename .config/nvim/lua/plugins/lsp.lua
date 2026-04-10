return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = require("constants.lsp_servers").mason,
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      { "neovim/nvim-lspconfig" },
    },
    lazy = false,
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
  -- For D2 Diagrams
  {
    "terrastruct/d2-vim",
    ft = { "d2" },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
