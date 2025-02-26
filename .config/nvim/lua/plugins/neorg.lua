-- Neorg/Note work related plugins
return {
    {
        "nvim-neorg/neorg",
        lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
        enabled = false,
        version = "*", -- Pin Neorg to the latest stable release
        config = function()
            require('neorg').setup {
                load = {
                    -- Load the basic Neorg modules
                    ['core.defaults'] = {},  -- Load default modules
                    ['core.concealer'] = {},
                    ['core.dirman'] = {    -- Agenda module for task and event management
                        config = {
                            -- Agenda view settings
                            workspaces = {
                                notes = "~/notes"
                            }
                        }
                    },
                }
            }
        end,
    },
    {
        'danilshvalov/org-modern.nvim',
        event = 'VeryLazy',
    },
    {
        'nvim-orgmode/orgmode',
        event = 'VeryLazy',
        dependencies = {'danilshvalov/org-modern.nvim',},
        config = function()
            local Menu = require("org-modern.menu")

            require('orgmode').setup({
                org_agenda_files = {
                    '~/notes/**/*',
                },
                org_default_notes_file = '~/notes/refile.org',
                org_capture_templates = {
                    r = {

                    }
                },
                win_split_mode = 'vsplit',
                notifications = {
                    enabled = true,
                },
                ui = {
                    menu = {
                        handler = function(data)
                            Menu:new({
                                window = {
                                    margin = { 1, 0, 1, 0 },
                                    padding = { 0, 1, 0, 1 },
                                    title_pos = "center",
                                    border = "single",
                                    zindex = 1000,
                                },
                                icons = {
                                    separator = "➜",
                                },
                            }):open(data)
                        end,
                    },
                    input = {
                        use_vim_ui = true,
                    },
                },
            })
        end,
    },
    {
        'nvim-orgmode/org-bullets.nvim',
        event = 'VeryLazy',
        enabled = false,
        config = true,
    },
}
