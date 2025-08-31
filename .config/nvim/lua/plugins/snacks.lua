-- from https://github.com/MaximilianLloyd/ascii.nvim
local header = [[



  ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆
   ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦
         ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄
          ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄
         ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀
  ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄
 ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄
⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄
⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄
     ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆
      ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃

]]

-- from https://github.com/freddiehaddad/nvim
local footer = [[
▀ ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀ ▀ ▀▀▀▀▀▀▀▀▀▀▀▀▀ ▀
                                      n e o v i m   ]]

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        width = 52,
        preset = {
          header = header,
        },
        sections = {
          { section = "header", gap = 0, padding = 0 },
          { section = "keys",   gap = 1, padding = 1 },
          {
            text = {
              {
                footer,
                hl = "SnacksDashboardHeader",
              },
            },
            gap = 0,
            padding = 1,
          },
          { section = "startup", gap = 0, padding = 0 },
        }
      },
      explorer = { enabled = true },
      indent = { enabled = true, chunk = { enabled = false, } },
      input = {
        enabled = true,
        animate = {
          enabled = vim.fn.has("nvim-0.10") == 1,
          style = "out",
          easing = "linear",
          duration = {
            step = 10,   -- ms per step
            total = 100, -- maximum duration
          },
        },
      },
      picker = {
        enabled = true,
        ui_select = true, -- use picker for vim.ui.select
        -- TODO: layout = ,
      },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      -- { "<leader>f",     function() Snacks.picker.files() end,                                                        desc = "Find Files" },
      -- { "<leader>,",     function() Snacks.picker.buffers() end,                                                      desc = "Buffers" },
      -- { "<leader>l",     function() Snacks.picker.grep() end,                                                         desc = "Grep for lines" },
      -- Grep
      { "<leader>Sb",    function() Snacks.picker.lines() end,                                                        desc = "Search for lines in [B]uffer" },
      { "<leader>sw",    function() Snacks.picker.grep_word() end,                                                    desc = "Visual selection or word",       mode = { "n", "x" } },
      -- LSP
      { "gd",            function() Snacks.picker.lsp_definitions() end,                                              desc = "[G]oto [D]efinition" },
      { "gD",            function() Snacks.picker.lsp_declarations() end,                                             desc = "[G]oto [D]eclaration" },
      { "gr",            function() Snacks.picker.lsp_references() end,                                               nowait = true,                           desc = "[G]oto [R]eferences" },
      { "gI",            function() Snacks.picker.lsp_implementations() end,                                          desc = "[G]oto [I]mplementation" },
      { "gt",            function() Snacks.picker.lsp_type_definitions() end,                                         desc = "Goto [T]ype Definition" },
      { '<leader>ds',    function() Snacks.picker.lsp_symbols() end,                                                  desc = '[D]ocument [S]ymbols' },
      { '<leader>dS',    function() Snacks.picker.lsp_workspace_symbols() end,                                        desc = '[W]orkspace [S]ymbols' },

      -- Rare
      { '<leader><c-k>', function() Snacks.picker.keymaps() end,                                                      desc = 'Show keymaps' },
      { '<leader>snh',   function() Snacks.picker.notifications({ layout = { preset = 'bottom' }, confirm = "put" }) end, desc = '[S]how [N]otification [H]istory' },
    }
  }
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
