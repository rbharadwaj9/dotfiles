-- ember_custom/palette.lua
-- A bolder, more saturated take on the ember-theme/nvim dark palette.
-- Base ramp: same hue/saturation as upstream `ember`, background tier (bg,
-- bg_alt, base0, base2) darkened ~5L for more contrast headroom. base3+, fg,
-- and fg_alt are unchanged — they already read fine at normal brightness.
-- Accents: replaced with saturated, well-separated hues (7 of 8 lifted
-- directly from the rhydlewis/obsidian-ember Obsidian theme's code-syntax
-- tokens; `steel` has no equivalent there — it's a warm palette with no
-- blue — so it's hand-picked to match the others' saturation/lightness).

local M = {}

local palette = {
  type   = "dark",
  bg     = "#0e0d0c",  -- H45 S6%  L5%
  bg_alt = "#151414",  -- H30 S4%  L8%
  base0  = "#060505",  -- H40 S8%  L2%
  base1  = "#0e0d0c",  -- H45 S6%  L5% (= bg)
  base2  = "#181716",  -- H40 S5%  L9%
  base3  = "#2e2d2a",  -- H42 S5%  L17%
  base4  = "#3e3c38",  -- H42 S5%  L23%
  base5  = "#585550",  -- H40 S5%  L33%
  base6  = "#706c61",  -- H43 S8%  L41%
  base7  = "#908a7e",  -- H42 S8%  L53%
  base8  = "#b8b0a0",  -- H40 S12% L68%
  fg     = "#d8d0c0",  -- H42 S16% L82%
  fg_alt = "#b0a898",  -- H38 S12% L64%

  -- Accents
  coral  = "#e8732c",  -- H23 S80% L54% — Obsidian ember-core / code-keyword
  orange = "#d0571a",  -- H18 S79% L46% — Obsidian ember-h4
  gold   = "#ffc26a",  -- H35 S100% L71% — Obsidian ember-accent / code-function
  olive  = "#8bd17a",  -- H108 S54% L67% — Obsidian code-string
  sage   = "#5fd6c2",  -- H170 S62% L64% — Obsidian code-property
  steel  = "#5aa9e6",  -- H207 S72% L64% — invented, no blue in source theme
  rose   = "#f06a5d",  -- H8 S85% L67% — Obsidian ember-fail / code-tag
  mauve  = "#b388ff",  -- H262 S100% L77% — Obsidian code-value / task-purple
}

--- Return the full palette table.
---@return table  flat palette with bg, fg, and accents
function M.get()
  return vim.deepcopy(palette)
end

return M
