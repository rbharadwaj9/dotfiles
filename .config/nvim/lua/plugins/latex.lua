return {
  {
    "lervag/vimtex",
    ft = {"tex"},
    -- lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "general"
      -- vim.g.vimtex_compiler_method = "generic"
      -- vim.g.vimtex_compiler_generic = {
      --   command = "./dockerlatexmk.sh -output-directory=build -pdf -verbose -file-line-error -interaction=nonstopmode",
      -- }
      -- vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_quickfix_open_on_warning = 0
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        out_dir = "build",  -- optional: put aux/pdf files into ./build
        callback = 1,
        continuous = 1,
        executable = "./dockerlatexmk.sh",  -- <--- your wrapper script
        options = {
           '-verbose',
           '-file-line-error',
           '-synctex=1',
           '-interaction=nonstopmode',
        },
      }
    end
  },
  {
    'preservim/vim-pencil',
    ft = {"tex", "markdown"},
  },
  {
    "junegunn/goyo.vim",
  }
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
