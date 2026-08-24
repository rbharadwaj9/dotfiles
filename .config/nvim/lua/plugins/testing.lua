return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
      "orjangj/neotest-ctest",
    },
    ft = { "cpp", "c" },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-ctest").setup({}),
        },
      })
    end,
    keys = {
      { "<leader>nr", function() require("neotest").run.run() end,                          desc = "[N]eotest [R]un nearest" },
      { "<leader>nf", function() require("neotest").run.run(vim.fn.expand("%")) end,         desc = "[N]eotest run [F]ile" },
      { "<leader>nl", function() require("neotest").run.run_last() end,                      desc = "[N]eotest run [L]ast" },
      { "<leader>nS", function() require("neotest").run.stop() end,                          desc = "[N]eotest [S]top" },
      { "<leader>ns", function() require("neotest").summary.toggle() end,                    desc = "[N]eotest [S]ummary" },
      { "<leader>no", function() require("neotest").output.open({ enter = true }) end,       desc = "[N]eotest [O]utput" },
      { "<leader>nO", function() require("neotest").output_panel.toggle() end,                desc = "[N]eotest [O]utput panel" },
    },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
