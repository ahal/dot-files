return {
  "nvim-neotest/neotest",
  keys = {
    {
      "<leader>tr",
      function() require("neotest").run.run() end,
      desc = "(R)un Nearest Test",
    },
    {
      "<leader>ta",
      function() require("neotest").run.run(vim.fn.expand("%")) end,
      desc = "Run (A)ll Tests in Current File",
    },
    {
      "<leader>td",
      function() require("neotest").run.run({strategy = "dap"}) end,
      desc = "(D)ebug Nearest Test",
    },
    {
      "<leader>ts",
      function() require("neotest").summary.toggle() end,
      desc = "Toggle (S)ummary Window",
    },
    {
      "<leader>to",
      function() require("neotest").output_panel.toggle() end,
      desc = "Toggle (O)utput Window",
    },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
          args = {"-vv"},
        }),
      }
    })
  end,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-neotest/neotest-python",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter"
  },
}
