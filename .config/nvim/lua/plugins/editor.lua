-- Editor enhancements
return {
  -- Tree sitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local ensureInstalled = {
        "c", "lua", "vim", "vimdoc", "query", "javascript", "html", "markdown", "markdown_inline", "python", "bash",
        "bibtex", "cmake", "cpp", "csv", "dockerfile", "git_config", "git_rebase", "gitcommit", "json", "make", "regex",
        "tmux", "yaml"
      }
      local alreadyInstalled = require('nvim-treesitter.config').get_installed()
      local parsersToInstall = vim.iter(ensureInstalled)
          :filter(function(parser)
            return not vim.tbl_contains(alreadyInstalled, parser)
          end)
          :totable()
      require('nvim-treesitter').install(parsersToInstall)

      vim.api.nvim_create_autocmd('FileType', {
        pattern = '*',
        callback = function()
          -- Enable treesitter highlighting and disable regex syntax
          pcall(vim.treesitter.start)
          -- Enable treesitter-based indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end
    -- config = function()
    --   local configs = require("nvim-treesitter.configs")
    --
    --   configs.setup({
    --     ensure_installed = {
    --     ignore_install = { "latex" },
    --     auto_install = true,
    --     sync_install = false,
    --     highlight = {
    --       enable = true,
    --       indent = {
    --         enable = true,
    --
    --       },
    --       -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    --       -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    --       -- Using this option may slow down your editor, and you may see some duplicate highlights.
    --       -- Instead of true it can also be a list of languages
    --       additional_vim_regex_highlighting = false,
    --     },
    --     indent = { enable = true },
    --   })
    -- end
  },
  {
    "nvim-treesitter/playground",
    lazy = true, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  },
  -- Git stuff
  {
    'tpope/vim-fugitive',
    event = "BufEnter",
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text_pos = 'right_align',
        delay = 1000,
      },
    },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
