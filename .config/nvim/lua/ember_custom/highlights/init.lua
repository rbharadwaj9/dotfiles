local M = {}

function M.get(theme)
  local highlights = {}

  -- Core highlights
  local modules = {
    "ember_custom.highlights.editor",
    "ember_custom.highlights.syntax",
    "ember_custom.highlights.treesitter",
    "ember_custom.highlights.lsp",
    "ember_custom.highlights.diagnostic",
  }

  -- Plugin highlights
  local plugins = {
    "ember_custom.highlights.plugins.gitsigns",
    "ember_custom.highlights.plugins.telescope",
    "ember_custom.highlights.plugins.cmp",
    "ember_custom.highlights.plugins.which-key",
    "ember_custom.highlights.plugins.neo-tree",
    "ember_custom.highlights.plugins.indent-blankline",
    "ember_custom.highlights.plugins.mini",
    "ember_custom.highlights.plugins.lazy",
    "ember_custom.highlights.plugins.noice",
    "ember_custom.highlights.plugins.snacks",
    -- lualine is handled separately (different format)
  }

  for _, mod_name in ipairs(modules) do
    local mod = require(mod_name)
    local hl = mod.get(theme)
    highlights = vim.tbl_deep_extend("force", highlights, hl)
  end

  for _, mod_name in ipairs(plugins) do
    local ok, mod = pcall(require, mod_name)
    if ok and mod.get then
      local hl = mod.get(theme)
      highlights = vim.tbl_deep_extend("force", highlights, hl)
    end
  end

  return highlights
end

return M
