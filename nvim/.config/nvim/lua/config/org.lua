-- Configurations related to when working in org-mode
vim.api.nvim_create_autocmd("FileType", {
    pattern = "org", -- Trigger only for Org files
    callback = function()
        vim.opt.conceallevel = 2
        vim.opt.concealcursor = 'nc'
    end,
})

-- Pickers to make org mode discoverable
vim.keymap.set('n', '<leader>of', function()
        require("snacks").picker.files({
            cwd = "~/notes", -- Change this to your actual Org directory
        })
    end,
    { desc = "[Org] [O]pen file", })
