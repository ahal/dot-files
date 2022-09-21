lua << EOF
require("neotest").setup({
    adapters = {
        require("neotest-python")({
            dap = { justMyCode = false },
            runner = "pytest",
        })
    }
})

vim.api.nvim_create_user_command(
    'Test',
    require("neotest").run.run,
    {desc = 'Run the nearest test'}
)
EOF
