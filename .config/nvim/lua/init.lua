-- All the configuration done in lua for neovim will be enabled from here

-- Setup lualine
require('lualine').setup({
    options = {
        globalstatus = true
    },
})

require("bufferline").setup{}

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

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- Setup nvim-tree
require("nvim-tree").setup({
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

require("telescope_config")