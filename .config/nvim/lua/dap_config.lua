local dap = require("dap")

-- Python
local python_path = table.concat({ vim.fn.stdpath('data'),  'mason', 'packages', 'debugpy', 'venv', 'bin', 'python'}, '/'):gsub('//+', '/')
require('dap-python').setup(python_path)

-- TODO: Figure out how to do this dynamically instead
table.insert(dap.configurations.python, {
    type = 'python',
    request = 'attach',
    name = 'Attach (all)',
    connect = {
      host = "127.0.0.1",
      port = 5678
    },
    justMyCode = false,
    mode = "remote",
})


-- C / C++ (codelldb via Mason)
local mason_registry = require('mason-registry')
local codelldb_extension_path = mason_registry.get_package('codelldb'):get_install_path() .. '/extension/'

dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
        command = codelldb_extension_path .. 'adapter/codelldb',
        args = { '--port', '${port}' },
    },
}

dap.configurations.cpp = {
    {
        name = 'Launch (pick executable)',
        type = 'codelldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Executable: ', vim.fn.getcwd() .. '/build/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },
    {
        -- For a process you launch yourself (locally, over ssh, in a
        -- container, on a device) under a debug stub that speaks the
        -- gdb-remote protocol (macOS: `debugserver host:port -- prog`,
        -- Linux: `lldb-server gdbserver host:port -- prog`). codelldb has no
        -- dedicated host/port attach fields, so this drives it with raw LLDB
        -- commands instead.
        name = 'Attach to remote (gdb-remote)',
        type = 'codelldb',
        request = 'launch',
        targetCreateCommands = function()
            local program = vim.fn.input('Local binary (for symbols): ', vim.fn.getcwd() .. '/', 'file')
            return { 'target create ' .. program }
        end,
        processCreateCommands = function()
            local addr = vim.fn.input('Remote address (host:port): ', 'localhost:1234')
            return { 'gdb-remote ' .. addr }
        end,
    },
}
dap.configurations.c = dap.configurations.cpp

-- Virtual Text. Requires Treesitter
require("nvim-dap-virtual-text").setup()

-- DAP UI. Manual toggle only -- no auto open/close on session start/end, so
-- debugging doesn't reshuffle the layout unless asked to.
require('dapui').setup()
vim.keymap.set('n', '<leader>du', function() require('dapui').toggle() end, { desc = 'Toggle DAP UI' })

-- In source buffers, K shows the DAP value under the cursor instead of the
-- usual LSP hover, but only while a DAP UI window (scopes/watches/etc) is
-- visible -- merely having a debug session running isn't enough. Checked
-- live on every press rather than tracked via open/close events, so it can't
-- drift out of sync with dapui auto-opening/closing or being closed with :q.
local function dapui_is_open()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.bo[vim.api.nvim_win_get_buf(win)].filetype:match('^dapui_') then
      return true
    end
  end
  return false
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.dap_hover', {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not (client and client:supports_method('textDocument/hover')) then
      return
    end
    vim.keymap.set('n', 'K', function()
      if dapui_is_open() then
        require('dap.ui.widgets').hover()
      else
        vim.lsp.buf.hover()
      end
    end, { buffer = ev.buf, desc = 'Hover (DAP value if DAP UI is open, else LSP)' })
  end,
})

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

local terminal_win_cmd_original = dap.defaults.fallback.terminal_win_cmd

dap.defaults.fallback.terminal_win_cmd = function()
    if dapui_is_open() then
        return terminal_win_cmd_original()
    else
        local rval = toggle_floating_terminal()
        vim.keymap.set({'t', 'n'}, 'q', _close_win_if_valid, { buffer = rval.buf, silent = true, noremap = true, nowait = true, desc = "Close floating terminal" })
        return rval.buf, rval.win
    end
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

require('util.snacks_menu').register('debug_actions', {
  { text = "continue",         desc = "Start or continue the debug session",        action = function() dap.continue() end },
  { text = "step-over",        desc = "Step over the current line",                 action = function() dap.step_over() end },
  { text = "step-into",        desc = "Step into the current function call",        action = function() dap.step_into() end },
  { text = "step-out",         desc = "Step out of the current function",           action = function() dap.step_out() end },
  { text = "toggle-breakpoint", desc = "Toggle a breakpoint on the current line",   action = function() dap.toggle_breakpoint() end },
  { text = "set-breakpoint",   desc = "Set a conditional breakpoint on the current line", action = function() dap.set_breakpoint() end },
  { text = "clear-breakpoints", desc = "Clear all breakpoints",                     action = function() dap.clear_breakpoints(); print("Clear Breakpoints") end },
  { text = "pause",            desc = "Pause the running program",                  action = function() dap.pause() end },
  { text = "run-last",         desc = "Re-run the last debug configuration",        action = function() dap.run_last() end },
  { text = "terminate",        desc = "Terminate the debug session",                action = function() dap.terminate() end },
  { text = "repl",             desc = "Open the DAP REPL",                          action = function() require('dap').repl.open() end },
  { text = "hover",            desc = "Show the value of the expression under the cursor", action = function() require('dap.ui.widgets').hover() end },
  { text = "preview",          desc = "Preview the value of the visual selection",  action = function() require('dap.ui.widgets').preview() end },
  { text = "frames",           desc = "Show the stack frames",                      action = function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
  end },
  { text = "toggle-ui",        desc = "Toggle the DAP UI",                          action = function() require('dapui').toggle() end },
  { text = "toggle-terminal",  desc = "Toggle the floating DAP terminal",           action = toggle_floating_terminal },
})

vim.keymap.set('n', '<leader>dm', function() Snacks.picker.debug_actions() end, { desc = 'Debug Actions' })
