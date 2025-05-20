-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here. They will automatically be installed (if provided within Mason)
return {
    mason = { 'clangd', 'ts_ls', 'lua_ls', 'lemminx', 'basedpyright', }, -- 'ruff', 'black', 'autopep8', 'pylsp', 'isort', },
    other = { 'solargraph' },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
