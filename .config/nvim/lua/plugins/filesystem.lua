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
            {'<leader>to', "<cmd>NvimTreeFocus<cr>", desc = "[T]ree [O]pen", nowait = true, silent = true},
            {'<leader>tt', "<cmd>NvimTreeToggle<cr>", desc = "[T]ree [T]oggle", nowait = true, silent = true},
            {'<leader>tc', "<cmd>NvimTreeClose<cr>", desc = "[T]ree [C]lose", nowait = true, silent = true},
            {'<leader>tf', "<cmd>NvimTreeFindFile<cr>", desc = "[T]ree [F]ind File", nowait = true, silent = true},
        },
    },
}
