-- Configurations related to when working in org-mode
print("ORG CONFIG CALLED")
vim.api.nvim_create_autocmd("FileType", {
  pattern = "org",  -- Trigger only for Org files
  callback = function()
    vim.opt.conceallevel = 2
    vim.opt.concealcursor = 'nc'
  end,
})
