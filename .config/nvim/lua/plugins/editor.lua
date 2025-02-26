-- Editor enhancements
return {
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
    }
}
