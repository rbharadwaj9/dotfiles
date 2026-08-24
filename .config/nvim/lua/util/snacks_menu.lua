-- Registers a Snacks picker "extension": a named source backed by a static
-- list of actions with real descriptions, instead of fuzzy-filtering over
-- command names (see Snacks.picker.commands). Analogous to a Telescope
-- extension's `register_extension({ exports = {...} })`.
--
-- Usage:
--   require('util.snacks_menu').register('cmake_actions', {
--     { text = 'build', desc = 'Build current target', action = function() vim.cmd('CMakeBuild') end },
--   })
--   -- then, anywhere: Snacks.picker.cmake_actions()

local M = {}

-- Session-only recency, per source: "<name>:<text>" -> last used time (hrtime).
-- Drives the default (empty-query) ordering, same idea as the files picker's
-- frecency bonus, but scoped to menu items instead of file paths.
local last_used = {}

---@param name string source name; invoke via Snacks.picker[name]()
---@param items { text: string, desc: string, action: fun() }[]
function M.register(name, items)
  for i, item in ipairs(items) do
    item.cmd = item.text -- reuse the built-in "command" formatter (text + desc)
    item.idx = i
  end
  Snacks.config.picker.sources[name] = {
    finder = function()
      local sorted = vim.list_slice(items, 1, #items)
      table.sort(sorted, function(a, b)
        local ta, tb = last_used[name .. ":" .. a.text], last_used[name .. ":" .. b.text]
        if ta or tb then
          return (ta or 0) > (tb or 0)
        end
        return a.idx < b.idx
      end)
      return sorted
    end,
    format = "command",
    layout = { preset = "vscode" },
    confirm = function(picker, item)
      last_used[name .. ":" .. item.text] = vim.uv.hrtime()
      picker:close()
      item.action()
    end,
  }
end

return M

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
