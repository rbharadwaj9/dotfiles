local M = {}

---@class EmberCustom.Config
---@field styles table
---@field on_colors? fun(palette: table)
---@field on_highlights? fun(highlights: table, theme: table)
---@field transparent boolean
---@field transparent_floats? boolean

---@class EmberCustom.Options
---@field styles? table
---@field on_colors? fun(palette: table)
---@field on_highlights? fun(highlights: table, theme: table)
---@field transparent? boolean
---@field transparent_floats? boolean

---@type EmberCustom.Config
M.config = {
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
    functions = {},
    types = { bold = true },
  },
  on_colors = nil,
  on_highlights = nil,
  transparent = false,
  transparent_floats = nil,
}

---@param opts? EmberCustom.Options
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

function M.load()
  -- Clear existing highlights
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors = true
  vim.o.background = "dark"
  vim.g.colors_name = "ember-custom"

  -- Build palette
  local palette = require("ember_custom.palette").get()

  -- User palette overrides
  if M.config.on_colors then
    M.config.on_colors(palette)
  end

  -- Build semantic theme
  local theme = require("ember_custom.theme").setup(palette, M.config)

  -- Collect all highlight groups
  local highlights = require("ember_custom.highlights").get(theme)

  -- User highlight overrides
  if M.config.on_highlights then
    M.config.on_highlights(highlights, theme)
  end

  -- Apply all highlights
  for group, hl in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, hl)
  end

  -- Set terminal colors
  if theme.term then
    for i = 0, 15 do
      vim.g["terminal_color_" .. i] = theme.term[i]
    end
  end
end

return M
