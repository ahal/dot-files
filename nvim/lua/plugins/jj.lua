return {
  "nicolasgb/jj.nvim",
  config = function()
    require("jj").setup({})

    -- Use the cmd module for jj commands
    local cmd = require("jj.cmd")
    vim.keymap.set("n", "<leader>jd", cmd.diff, { desc = "JJ diff" })
    vim.keymap.set("n", "<leader>jD", cmd.describe, { desc = "JJ describe" })
    vim.keymap.set("n", "<leader>jl", cmd.log, { desc = "JJ log" })
    vim.keymap.set("n", "<leader>je", cmd.edit, { desc = "JJ edit" })
    vim.keymap.set("n", "<leader>jn", cmd.new, { desc = "JJ new" })
    vim.keymap.set("n", "<leader>js", cmd.status, { desc = "JJ status" })
    vim.keymap.set("n", "<leader>jS", cmd.squash, { desc = "JJ squash" })

    vim.keymap.set("n", "<leader>jt", function()
      cmd.j "tug"
      cmd.log {}
    end, { desc = "JJ tug" })
  end,
}
