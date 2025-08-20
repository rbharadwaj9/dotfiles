vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    -- Remove trailing whitespace
    vim.cmd([[%s/\s\+$//e]])
  end
})

-- All the configuration done in lua for neovim will be enabled from here
vim.keymap.set("n", "<leader>z", function()
  -- Get content of current buffer
  local ft = vim.bo.filetype
  local cur_pos = vim.api.nvim_win_get_cursor(0)  -- {line, col}
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  -- Open a new tab with a new scratch buffer
  vim.cmd("tabnew")
  local buf = vim.api.nvim_create_buf(false, true) -- [listed=false], [scratch=true]
  vim.api.nvim_win_set_buf(0, buf)

  -- Insert lines
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Clean UI
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.signcolumn = "no"
  vim.opt_local.foldcolumn = "0"
  vim.opt_local.statuscolumn = ""
  vim.opt_local.cursorline = false
  vim.opt_local.colorcolumn = ""
  vim.opt_local.wrap = false
  vim.bo[buf].filetype = ft
  -- vim.cmd("syntax off")

  -- Move cursor back to same position
  local target_line = math.min(cur_pos[1], #lines)
  local target_col = cur_pos[2]
  local line_text = lines[target_line] or ""
  if target_col > #line_text then
    target_col = #line_text
  end
  vim.api.nvim_win_set_cursor(0, {target_line, target_col})

  -- Optional: visually select all text
  -- vim.cmd("normal! ggVG")
end, { desc = "Open clean tab for copy-paste" })

-- TODO: Add some special background so that it looks different

vim.keymap.set("n", "<c-q>", "<cmd>enew<CR>", { desc = "New empty buffer" })

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "dap-float",
    "help"
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- close some filetypes with <q> (buffer delete)
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "dap-terminal",
  },
  callback = function(event)
    vim.keymap.set("n", "q", "<cmd>bdelete!<cr>", { buffer = event.buf, silent = true })
  end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
