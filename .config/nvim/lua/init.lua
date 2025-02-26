-- All the configuration done in lua for neovim will be enabled from here

-- Setup lualine
require('lualine').setup({
    options = {
        globalstatus = true
    },
})

-- Bufferline
local bufferline = require("bufferline")
bufferline.setup({
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
})

vim.keymap.set('n', "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>")
vim.keymap.set('n', "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>")
vim.keymap.set('n', "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>")
vim.keymap.set('n', "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>")
vim.keymap.set('n', "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>")
vim.keymap.set('n', "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>")
vim.keymap.set('n', "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>")
vim.keymap.set('n', "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>")
vim.keymap.set('n', "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>")
vim.keymap.set('n', "<leader>$", "<cmd>BufferLineGoToBuffer -1<cr>")

require('winbar').setup({
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
})

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Setup LSP and Completion (done inside LSP)
require 'lsp'

-- Setup Formatter
require 'formatter_config'

-- Setup DAP
require 'dap_config'

-- Oil for file manager
require("oil").setup()

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- Setup nvim-tree
require("nvim-tree").setup({
    filters = {
        dotfiles = false,
        git_ignored = false,
        custom = { 'node_modules', '__pycache__' },
    },
    renderer = {
        group_empty = true,
    },
})

vim.keymap.set('n', '<leader>to', "<cmd>NvimTreeFocus<cr>")
vim.keymap.set('n', '<leader>tt', "<cmd>NvimTreeToggle<cr>")
vim.keymap.set('n', '<leader>tc', "<cmd>NvimTreeClose<cr>")
vim.keymap.set('n', '<leader>tf', "<cmd>NvimTreeFindFile<cr>")

require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = { "c", "rust" },
        indent = {
            enable = true
        },
        -- -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        -- disable = function(lang, buf)
            --     local max_filesize = 100 * 1024 -- 100 KB
            --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            --     if ok and stats and stats.size > max_filesize then
            --         return true
            --     end
            -- end,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },
    })

    -- require("telescope_config")
    require('config.init')
