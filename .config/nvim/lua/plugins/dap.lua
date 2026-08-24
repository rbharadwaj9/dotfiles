-- Debugging (DAP)
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = { "codelldb", "clang-format" },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    -- Loaded eagerly: dap_config.lua (required from lua/init.lua, after
    -- lazy.nvim has loaded) does `require("dap")` unconditionally at startup.
    lazy = false,
  },
  {
    "igorlfs/nvim-dap-view",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    opts = {},
    lazy = true,
    -- keys = {
    --   { "<leader>Du", require("dap-view").toggle(), nowait = true, desc = "Open nvim-dap-view UI"},
    -- },
  }
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
