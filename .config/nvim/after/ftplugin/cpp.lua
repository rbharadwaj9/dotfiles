-- Keymaps
vim.keymap.set("n", "<C-h>", "<cmd>LspClangdSwitchSourceHeader<CR>", { buffer = true, silent = true })

-- a.vim-style :A/:AS/:AV/:AT commands, backed by clangd's switchSourceHeader
-- LSP extension instead of a.vim's filename/path heuristics. There's no
-- equivalent to a.vim's :AN since clangd returns a single best match rather
-- than a list of candidates to cycle through.
local function switch_source_header(open_cmd)
  return function()
    local bufnr = vim.api.nvim_get_current_buf()
    local method = "textDocument/switchSourceHeader"
    local client = vim.lsp.get_clients({ bufnr = bufnr, name = "clangd" })[1]
    if not client or not client:supports_method(method) then
      return vim.notify("clangd not attached to this buffer", vim.log.levels.WARN)
    end
    client:request(method, vim.lsp.util.make_text_document_params(bufnr), function(err, result)
      if err then
        return vim.notify(tostring(err), vim.log.levels.ERROR)
      end
      if not result then
        return vim.notify("No alternate file found", vim.log.levels.WARN)
      end
      vim.cmd(open_cmd .. " " .. vim.fn.fnameescape(vim.uri_to_fname(result)))
    end, bufnr)
  end
end

vim.api.nvim_buf_create_user_command(0, "A", switch_source_header("edit"), { desc = "Switch to alternate file" })
vim.api.nvim_buf_create_user_command(0, "AS", switch_source_header("split"), { desc = "Switch to alternate file (split)" })
vim.api.nvim_buf_create_user_command(0, "AV", switch_source_header("vsplit"), { desc = "Switch to alternate file (vsplit)" })
vim.api.nvim_buf_create_user_command(0, "AT", switch_source_header("tabedit"), { desc = "Switch to alternate file (tab)" })
