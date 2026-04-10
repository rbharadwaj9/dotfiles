-- Custom LSP configurations
-- These are not enabled by Mason and have to be managed completely here.
-- The LSP installation is managed by Mason though.

-- Example custom configuration for lua
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

vim.lsp.config["lua_ls"] = {
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

vim.lsp.config["yamlls"] = {
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
}

vim.lsp.config["jsonls"] = {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}

vim.lsp.enable({"lua_ls", "yamlls", "jasonls"})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
