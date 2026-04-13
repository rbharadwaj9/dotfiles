-- Code Completion, Formatting
return {
  {
    "github/copilot.vim",
    event = "BufEnter",
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      -- -- optional: provides snippets for the snippet source
      -- 'rafamadriz/friendly-snippets'
    },

    -- Lazyload
    event = "BufEnter",

    -- Use a release tag to download pre-built binaries
    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {

      -- Disable for specific filetypes and buffer types, or when completion is disabled
      enabled = function()
        return not vim.list_contains({ 'lazy', 'rip-substitute', 'dap-repl' }, vim.bo.filetype) and
            vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false
      end,

      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = 'default',

        ['<C-o>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-c>'] = { 'hide', 'fallback' },
        ['<C-e>'] = { 'select_and_accept', 'fallback' },
      },

      fuzzy = {
        implementation = "rust",
        sorts = {
          'exact',
          -- defaults
          'score',
          'sort_text',
        },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 50,
        },
        list = {
          max_items = 10,
        },
        menu = {
          draw = {
            padding = { 0, 1 }, -- padding only on right side
            components = {
              kind_icon = {
                text = function(ctx) return ' ' .. ctx.kind_icon .. ctx.icon_gap end
              }
            },
            columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_name' } },
          }
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'buffer' },
      },
      cmdline = {
        enabled = false,
      },
    },
    opts_extend = { "sources.default" }
  },
  {
    -- Keymaps to add/change surrounds
    'tpope/vim-surround',
    event = "InsertEnter",
  },
  {
    -- Bracket Completion
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
