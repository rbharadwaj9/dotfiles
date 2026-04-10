-- v0.12 update
-- Uses all sane defaults from nvim.
-- Only provides custom keymaps and configurations

local nmap = function(keys, func, desc)
  if desc then
    desc = 'LSP: ' .. desc
  end
  vim.keymap.set('n', keys, func, { buffer = buffnr, desc = desc })
end

-- Keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(ev)
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

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(ev.buf, 'Format', function(_)
      vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
    end, { desc = 'Format current buffer with LSP' })

  end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
