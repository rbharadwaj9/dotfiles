vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        -- Remove trailing whitespace
        vim.cmd([[%s/\s\+$//e]])
    end
})
