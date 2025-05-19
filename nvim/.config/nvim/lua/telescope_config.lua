-- Telescope Config

local action_state = require('telescope.actions.state')
require('telescope').setup{
    defaults = {
        prompt_prefix = "$ ",
        -- Mapping while inside telescope
        mappings = {
            i = {
                ["<c-a>"] = function() print(vim.inspect(action_state.get_selected_entry())) end
            }
        }
    },
    extensions = {
      fzf = {}
    }
}


-- -- To get fzf loaded and working with telescope, you need to call
-- -- load_extension, somewhere after setup function:
-- require('telescope').load_extension('fzf')
--
-- vim.keymap.set('n', '<leader>f', "<cmd>Telescope find_files<cr>")
-- vim.keymap.set('n', '<leader>gf', "<cmd>Telescope git_files<cr>")
-- vim.keymap.set('n', '<leader>l', "<cmd>Telescope live_grep<cr>")
--
-- vim.keymap.set('n', '<leader>ep', function()
--   require("telescope.builtin").find_files {
--     cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "plugged")
--   }
--   end)
--
-- -- The line beneath this is called `modeline`. See `:help modeline`
-- -- vim: ts=2 sts=2 sw=2 et
