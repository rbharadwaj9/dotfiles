-- v0.12 update
-- Uses all sane defaults from nvim.
-- Only provides custom keymaps and configurations

-- Global Keymaps (overrides and customs)

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = vim.v.count1, float = true })
end, { desc = 'Jump to the next diagnostic in the current buffer' })

vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ count = -vim.v.count1, float = true  })
end, { desc = 'Jump to the previous diagnostic in the current buffer' })

vim.keymap.set('n', ']D', function()
  vim.diagnostic.jump({ count = vim._maxint, float = true, wrap = false })
end, { desc = 'Jump to the last diagnostic in the current buffer' })

vim.keymap.set('n', '[D', function()
  vim.diagnostic.jump({ count = -vim._maxint, float = true, wrap = false })
end, { desc = 'Jump to the first diagnostic in the current buffer' })

-- Prefer conform (e.g. clang-format) and fall back to the LSP formatter if
-- conform has nothing configured for this filetype. Shared by the `:Format`
-- buffer command and the LSP actions menu below.
local function format_buffer(bufnr, client_id)
  bufnr = bufnr or 0
  local conform_ok, conform = pcall(require, 'conform')
  if conform_ok and #conform.list_formatters(bufnr) > 0 then
    conform.format({ bufnr = bufnr, timeout_ms = 1000 })
  else
    vim.lsp.buf.format({ bufnr = bufnr, id = client_id, timeout_ms = 1000 })
  end
end

require('util.snacks_menu').register('lsp_actions', {
  { text = "rename",           desc = "Rename the symbol under the cursor",              action = vim.lsp.buf.rename },
  { text = "code-action",      desc = "Show available code actions",                     action = vim.lsp.buf.code_action },
  { text = "hover",            desc = "Show hover information for the symbol under the cursor", action = vim.lsp.buf.hover },
  { text = "signature-help",   desc = "Show signature help for the current call",        action = vim.lsp.buf.signature_help },
  { text = "format",           desc = "Format the current buffer",                       action = format_buffer },
  { text = "incoming-calls",   desc = "Show incoming calls to the symbol under the cursor", action = function() Snacks.picker.lsp_incoming_calls() end, },
  { text = "outgoing-calls",   desc = "Show outgoing calls from the symbol under the cursor", action = function() Snacks.picker.lsp_outgoing_calls() end, },
  { text = "toggle-diagnostics", desc = "Enable/disable diagnostics",                    action = function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end },
  { text = "diagnostics-to-loclist", desc = "Send buffer diagnostics to the location list", action = vim.diagnostic.setloclist },
  { text = "workspace-add",    desc = "Add a folder to the LSP workspace",               action = vim.lsp.buf.add_workspace_folder },
  { text = "workspace-remove", desc = "Remove a folder from the LSP workspace",          action = vim.lsp.buf.remove_workspace_folder },
  { text = "workspace-list",   desc = "List LSP workspace folders",                      action = function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end },
  { text = "restart",          desc = "Restart attached LSP clients",                    action = function() vim.cmd("LspRestart") end },
  { text = "info",             desc = "Show attached LSP client info",                   action = function() vim.cmd("LspInfo") end },
})

vim.keymap.set('n', '<leader>L', function() Snacks.picker.lsp_actions() end, { desc = 'LSP Actions' })

-- Buffer Local Keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(ev)
    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end
      vim.keymap.set('n', keys, func, { buffer = ev.buf, desc = desc })
    end

    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

    -- Diagnostic keymaps
    nmap('<leader>q', vim.diagnostic.setloclist)
    nmap('<leader>ad', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end)

    -- Lesser used LSP functionality
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer.
    vim.api.nvim_buf_create_user_command(ev.buf, 'Format', function(_)
      format_buffer(ev.buf, client.id)
    end, { desc = 'Format current buffer' })

  end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
