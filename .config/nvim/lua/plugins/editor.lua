-- Editor enhancements
return {
    -- Tree sitter
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
        build = ":TSUpdate",
    },
    {
        "nvim-treesitter/playground",
        lazy = true, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    },
    -- Bracket Completion
    {
      'tpope/vim-surround'
    },
    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
    },
    -- Code Completion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippets
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            -- Helpers
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
        },
        event = "VeryLazy",
    },
    {
        'lewis6991/gitsigns.nvim',
        event = "BufEnter",
        config = true,
    },
}
