return {
  -- Tree sitter
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      view = {
        signcolumn = "auto",
      },
      filters = {
        dotfiles = false,
        git_ignored = false,
        custom = { 'node_modules', '__pycache__' },
      },
      renderer = {
        group_empty = true,
        full_name = true,
      },
      actions = {
        open_file = {
          quit_on_open = true,
        }
      },
      tab = {
        sync = {
          open = true,
          close = true,
        }
      }
    },
    keys = {
      { '<leader>to', "<cmd>NvimTreeFocus<cr>",    desc = "[T]ree [O]pen",      nowait = true, silent = true },
      { '<leader>tt', "<cmd>NvimTreeToggle<cr>",   desc = "[T]ree [T]oggle",    nowait = true, silent = true },
      { '<leader>tc', "<cmd>NvimTreeClose<cr>",    desc = "[T]ree [C]lose",     nowait = true, silent = true },
      { '<leader>tf', "<cmd>NvimTreeFindFile<cr>", desc = "[T]ree [F]ind File", nowait = true, silent = true },
    },
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    -- lazy = false,
    keys = {
      { '-', "<cmd>Oil<cr>", desc = "Open parent directory", nowait = true, silent = true },
    },
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "nvim-mini/mini.icons" },
    opts = {},
    keys = {
      { "<leader>f", function() FzfLua.files() end, desc = "Find Files" },
      { "<leader>,", function() FzfLua.buffers() end, desc = "Buffers" },
      { "<leader>l", function() FzfLua.live_grep() end, desc = "Live Grep" },
      { "<C-k>", function() FzfLua.builtin() end, desc = "Builtin" },
    }
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
