return {
  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = { "snacks_dashboard" },
          winbar = { "snacks_dashboard" },
        },
        ignore_focus = {
          -- "dap-repl",
          "dapui_breakpoints",
          "dapui_console",
          "dapui_scopes",
          "dapui_stacks",
          "dapui_watches",
        },
        always_divide_middle = true,
        always_show_tabline = false,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
          refresh_time = 16, -- ~60fps
          events = {
            'WinEnter',
            'BufEnter',
            'BufWritePost',
            'SessionLoadPost',
            'FileChangedShellPost',
            'VimResized',
            'Filetype',
            'CursorMoved',
            'CursorMovedI',
            'ModeChanged',
          },
        }
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'lsp_status', 'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {
        'nvim-tree',
        'oil',
        'quickfix'
      }
    },
  },
  {
    'akinsho/bufferline.nvim',
    enabled = true,
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = "BufReadPost",
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
  -- Winbar: LSP breadcrumb (namespace/class/function), toggleable
  {
    'SmiteshP/nvim-navic',
    lazy = true,
    opts = {
      highlight = true,
      separator = ' › ',
      depth_limit = 0,
    },
    init = function()
      vim.g.navic_winbar_enabled = true

      _G.navic_winbar = function()
        local ok, navic = pcall(require, 'nvim-navic')
        if not ok or not navic.is_available() then
          return ''
        end
        return navic.get_location()
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('navic-winbar', {}),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not (client and client.server_capabilities.documentSymbolProvider) then
            return
          end
          require('nvim-navic').attach(client, args.buf)
          if vim.g.navic_winbar_enabled then
            vim.wo[0].winbar = "%{%v:lua.navic_winbar()%}"
          end
        end,
      })

      vim.keymap.set('n', '<leader>ab', function()
        vim.g.navic_winbar_enabled = not vim.g.navic_winbar_enabled
        local navic = require('nvim-navic')
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          if navic.is_available(buf) then
            vim.wo[win].winbar = vim.g.navic_winbar_enabled and "%{%v:lua.navic_winbar()%}" or ''
          end
        end
      end, { desc = 'Toggle winbar [B]readcrumb' })
    end,
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
