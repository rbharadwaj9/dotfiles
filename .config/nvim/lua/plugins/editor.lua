-- Editor enhancements
return {
    -- Tree sitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "html", "markdown", "markdown_inline", "python", "bash", "bibtex", "cmake", "cpp", "csv", "dockerfile", "git_config", "git_rebase", "gitcommit", "json", "make", "regex", "tmux", "yaml" },
                auto_install = true,
                sync_install = false,
                highlight = {
                    enable = true,
                    indent = {
                        enable = true,

                    },
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
            })
        end
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
        enabled = false,
    },
    {
        'lewis6991/gitsigns.nvim',
        event = "BufEnter",
        config = true,
    },
    {
        'saghen/blink.cmp',
        dependencies = {
            -- -- optional: provides snippets for the snippet source
            -- 'rafamadriz/friendly-snippets'
            {
                'saghen/blink.compat',
                version = '*',
                opts = {},
            },
            "petertriho/cmp-git",
        },

        -- Lazyload
        event = "InsertEnter",

        -- use a release tag to download pre-built binaries
        version = '1.*',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'enter' },
            signature = { enabled = true },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                per_filetype = {
                    gitcommit = { 'git', 'buffer' },
                    org = { 'orgmode', },
                },
                providers = {
                    git = {
                        name = 'git',
                        module = 'blink.compat.source',
                    },
                    orgmode = {
                        name = 'orgmode',
                        module = 'blink.compat.source',
                    }
                },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
}
