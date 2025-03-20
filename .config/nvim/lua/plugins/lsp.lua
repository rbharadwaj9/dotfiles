return {
    {
      'williamboman/mason.nvim',
      lazy = false,
    },
    {
      'williamboman/mason-lspconfig.nvim',
      lazy = true,
    },
    {
      'j-hui/fidget.nvim',
      event = "LspAttach",
      config = true,
    },
}
