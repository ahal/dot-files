lua << EOF
require("null-ls").setup({
    sources = {
        require"null-ls".builtins.diagnostics.codespell.with({
            filetypes = { "markdown", "python", "rst" },
        }),
        require"null-ls".builtins.diagnostics.eslint_d,
        require"null-ls".builtins.diagnostics.flake8.with({
            extra_args = { "--max-line-length=100" },
        }),
        require"null-ls".builtins.diagnostics.markdownlint,
        require"null-ls".builtins.diagnostics.shellcheck,
        require"null-ls".builtins.diagnostics.yamllint.with {
            diagnostics_format = "#{m}"
        },
        require"null-ls".builtins.formatting.black,
        require"null-ls".builtins.formatting.eslint_d,
        require"null-ls".builtins.formatting.isort,
        require"null-ls".builtins.formatting.json_tool,
        require"null-ls".builtins.formatting.markdownlint,
        require"null-ls".builtins.formatting.stylua,
    },
    diagnostics_format = "[#{c}] #{m} (#{s})",
})
EOF
