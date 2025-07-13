return {
  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        globalstatus = false
      },
    }
  },
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function ()
      require("bufferline").setup{
        options = {
          mode = "tabs",
          diagnostics = "nvim_lsp",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              highlight = "Directory",
              separator = true
            }
          },
          hover = {
            enabled = false,
          },
          separator_style = "thin",
          show_buffer_close_icons = false,
          show_tab_indicators = false,
          style_preset = {},
          show_duplicate_prefix = false, -- whether to show duplicate buffer prefix
          numbers = "ordinal"
        }
      }
      vim.keymap.set('n', "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>")
      vim.keymap.set('n', "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>")
      vim.keymap.set('n', "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>")
      vim.keymap.set('n', "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>")
      vim.keymap.set('n', "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>")
      vim.keymap.set('n', "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>")
      vim.keymap.set('n', "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>")
      vim.keymap.set('n', "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>")
      vim.keymap.set('n', "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>")
      vim.keymap.set('n', "<leader>$", "<cmd>bufferlinegotobuffer -1<cr>")
      end,
  },
  -- Winbar
  {
    'fgheng/winbar.nvim',
    opts = {
      enabled = true,

      show_file_path = true,
      show_symbols = true,

      colors = {
        path = '', -- You can customize colors like #c946fd
        file_name = '',
        symbols = '',
      },

      icons = {
        file_icon_default = '',
        seperator = '>',
        editor_state = '●',
        lock_icon = '',
      },

      exclude_filetype = {
        'help',
        'startify',
        'dashboard',
        'packer',
        'neogitstatus',
        'NvimTree',
        'Trouble',
        'alpha',
        'lir',
        'Outline',
        'spectre_panel',
        'toggleterm',
        'qf',
      }
    }
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
