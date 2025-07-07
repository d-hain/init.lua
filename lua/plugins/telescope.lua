return {
    "nvim-telescope/telescope.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function(_, _)
        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>pf", function ()
            builtin.find_files {
                hidden = true,
                no_ignore = true,
                no_ignore_parent = true,
            }
        end, {})
        vim.keymap.set("n", "<leader>pg", builtin.live_grep, {})
    end,
}
