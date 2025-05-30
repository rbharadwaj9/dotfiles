local dap = require("dap")

-- Python
local python_path = table.concat({ vim.fn.stdpath('data'),  'mason', 'packages', 'debugpy', 'venv', 'bin', 'python'}, '/'):gsub('//+', '/')
require('dap-python').setup(python_path)

-- TODO: Figure out how to do this dynamically instead
table.insert(dap.configurations.python, {
    type = 'python',
    request = 'attach',
    name = 'Locoma Container Attach',
    connect = {
      host = "127.0.0.1",
      port = 5678
    },
    mode = "remote",
    pathMappings = {
      {
        localRoot = "/root/workspace",  -- e.g., /home/user/code
        remoteRoot = "/workspace" -- e.g., /app
      }
    }
})


-- Virtual Text. Requires Treesitter
-- require("nvim-dap-virtual-text").setup()

-- Open terminal as a floating window for dap

-- Define a variable to track the floating terminal window
local float_state = {
    win = -1,
    buf = -1
}

local function _close_win_if_valid()
    if vim.api.nvim_win_is_valid(float_state.win) then
        vim.api.nvim_win_hide(float_state.win)
        return true
    end
    return false
end

local function toggle_floating_terminal(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.5)
    local height = opts.height or math.floor(vim.o.lines * 0.5)

    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    if _close_win_if_valid() then
        return float_state
    end

    -- Create a new floating window
    local buf = nil
    if vim.api.nvim_buf_is_valid(float_state.buf) then
        buf = float_state.buf
    else
        buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer
    end

    local win_cfg = {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    }

    -- Open the floating window
    local win = vim.api.nvim_open_win(buf, true, win_cfg)

    float_state.win = win
    float_state.buf = buf

    -- Close window if it loses focus by some other event
    vim.api.nvim_create_autocmd("WinLeave", {
        buffer = buf, -- Only for the floating window buffer
        callback = function()
            _close_win_if_valid()
        end,
    })

    return { win = win, buf = buf }
end


dap.defaults.fallback.terminal_win_cmd = function()
    local rval = toggle_floating_terminal()
    vim.keymap.set({'t', 'n'}, 'q', _close_win_if_valid, { buffer = rval.buf, silent = true, noremap = true, nowait = true, desc = "Close floating terminal" })
    return rval.buf, rval.win
end
dap.defaults.fallback.focus_terminal = true

-- Map the toggle function to <leader>dt
vim.keymap.set("n", "<leader>dt", toggle_floating_terminal, { desc = "Toggle DAP Floating Terminal" })

-- Keybinds
vim.keymap.set('n', '<leader>dc', function() dap.continue() end)
vim.keymap.set('n', '<leader>dn', function() dap.step_over() end)
vim.keymap.set('n', '<leader>di', function() dap.step_into() end)
vim.keymap.set('n', '<leader>do', function() dap.step_out() end)
vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint() end)

vim.keymap.set('n', '<Leader>dr', function()
    require('dap').repl.open(
        -- Open as a vertical split on the right and give is 25% space
        -- TODO
    )
end)

vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)
vim.keymap.set('n', '<Leader>dbc', function() dap.clear_breakpoints(); print("Clear Breakpoints") end)
vim.keymap.set('n', '<Leader>de', function() dap.terminate() end)
vim.keymap.set('n', '<Leader>d<Leader>', function() dap.pause() end)

vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
-- vim.keymap.set('n', '<Leader>ds', function()
--   local widgets = require('dap.ui.widgets')
--   widgets.centered_float(widgets.scopes)
-- end)
