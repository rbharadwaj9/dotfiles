-- Native LSP Setup
-- This file aims to configure everything that nvim needs to connect and provide
-- information as an LSP client.
--
-- The user will still be required to install the appropriate Language Server
-- on their own. See https://langserver.org
local rval = {}

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>ak', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>aj', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>ad', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end)
-- vim.keymap.set('n', '<leader>ad', vim.diagnostic.setloclist)

-- -- LSP References Plugin
-- require 'nice-reference'.setup({
--     anchor = "NW", -- Popup position anchor
--     relative = "cursor", -- Popup relative position
--     row = 1, -- Popup x position
--     col = 0, -- Popup y position
--     border = "rounded", -- Popup borderstyle
--     winblend = 0, -- Popup transaparency 0-100, where 100 is transparent
--     max_width = 120, -- Max width of the popup
--     max_height = 10, -- Max height of the popup
--     auto_choose = false, -- Go to reference if there is only one
-- })

-- Code Context Plugin
local navic = require('nvim-navic')

local on_attach = function(client, buffnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, buffnr)
  end

  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = buffnr, desc = desc })
  end

  -- Trying out snacks picker instead. Check plugins/snacks.lua
  -- nmap("gd", vim.lsp.buf.definition, "[G]oto [D]ocumentation")
  -- nmap("gt", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")
  -- nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  -- nmap("gr", require ('nice-reference').references, "[G]oto [R]erferences")

  -- Documentation Reference --
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Smart Rename --
  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

  -- Code Action --
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  -- More keybinds are configured in the snacks settings.

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(buffnr, 'Format', function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = 'Format current buffer with LSP' })
end

-- nvim-cmp supports additional completion capabilities
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- local capabilities = require('completion')
local capabilities = require('blink.cmp').get_lsp_capabilities({}, true)

local enable_lsp = function(serv_list)
  for _, lsp in ipairs(serv_list) do
    require('lspconfig')[lsp].setup {
      -- Gets run inside every buffer that gets attached
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
end

enable_lsp(require("constants.lsp_servers").mason)
-- enable_lsp(servers.other)

-- Example custom configuration for lua
--
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require("lspconfig").basedpyright.setup {
  -- Gets run inside every buffer that gets attached
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    basedpyright = {
      analysis = {
        -- diagnosticMode = "openFilesOnly",
        inlayHints = {
          variableTypes = true,
          callArgumentNames = true
        }
      }
    }
  }
}

require('lspconfig').lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
    },
  },
}

require('lspconfig').yamlls.setup({
  settings = {
    yaml = {
      schemaStore = {
        -- disable in favor of schemastore plugin
        enable = false,
        url = "",
      },
      schemas = require("schemastore").yaml.schemas(),
    },
  },
  capabilities = require("blink.cmp").get_lsp_capabilities({}, true),
})

require('lspconfig').jsonls.setup({
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
  capabilities = require("blink.cmp").get_lsp_capabilities({}, true),
})

-- require('lspconfig').solargraph.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   cmd = {
--     vim.fn.glob(home .. "/.rbenv/versions/*/bin/solargraph"),
--     "stdio", -- Found from default configuration of coc-solargraph
--   },
-- }

rval.on_attach = on_attach

return rval

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
