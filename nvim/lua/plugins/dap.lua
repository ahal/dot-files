return {
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    keys = {
      {
        "<leader>db",
        function() require("dap").toggle_breakpoint() end,
        desc = "Toggle Breakpoint"
      },

      {
        "<leader>dc",
        function() require("dap").continue() end,
        desc = "Continue"
      },

      {
        "<leader>dC",
        function() require("dap").run_to_cursor() end,
        desc = "Run to Cursor"
      },

      {
        "<leader>dT",
        function() require("dap").terminate() end,
        desc = "Terminate"
      },
    },

  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      -- This line is essential to making automatic installation work
      handlers = {},
      automatic_installation = {
        -- These will be configured by separate plugins.
        exclude = {
          "python",
        },
      },
      -- DAP servers: Mason will be invoked to install these if necessary.
      ensure_installed = {
        "python",
      },
    },
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    lazy = true,
    config = function()
      require('dap-python').setup('uv')
      require('dap-python').test_runner = 'pytest'

      table.insert(require('dap').configurations.python, {
        name = 'Taskgraph Full',
        type = 'python',
        request = 'launch',
        program = 'taskgraph',
        args = {'full'},
        console = 'integratedTerminal',
        justMyCode = false,
      })
    end
  },
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = true,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    config = true,
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "Dap UI"
      },
    },
    dependencies = {
        "jay-babu/mason-nvim-dap.nvim",
        "mfussenegger/nvim-dap-python",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
    },
  },
}
