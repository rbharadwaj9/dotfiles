vim.opt.completeopt={"menu", "menuone", "noselect", "preview"}

-- Set up lua snip
local ls = require("luasnip")

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

-- Set up nvim-cmp.
-- local cmp = require 'cmp'
--
-- cmp.setup({
--   snippet = {
--     expand = function(args)
--       require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--     end,
--   },
--   window = {
--     -- completion = cmp.config.window.bordered(),
--     -- documentation = cmp.config.window.bordered(),
--   },
--   mapping = cmp.mapping.preset.insert({
--     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-s>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.abort(),
--     ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--   }),
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'luasnip' }, -- For luasnip users.
--   }, {
--     { name = 'buffer' },
--   })
-- })
--
-- -- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
--   }, {
--     { name = 'buffer' },
--   })
-- })
--
-- cmp.setup.filetype('org', {
--   sources = cmp.config.sources({
--     { name = 'orgmode' },
--   }, {
--     { name = 'buffer' },
--   })
-- })
--
-- -- -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
-- -- cmp.setup.cmdline({ '/', '?' }, {
-- --   mapping = cmp.mapping.preset.cmdline(),
-- --   sources = {
-- --     { name = 'buffer' }
-- --   }
-- -- })
--
-- -- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- -- cmp.setup.cmdline(':', {
-- --   mapping = cmp.mapping.preset.cmdline(),
-- --   sources = cmp.config.sources({
-- --     { name = 'path' }
-- --   }, {
-- --     { name = 'cmdline' }
-- --   })
-- -- })
--
-- -- Set up lspconfig.
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
--
-- return capabilities
