return {
    "nvim-telescope/telescope.nvim",
    version = "0.1.3",
    dependencies = "nvim-lua/plenary.nvim",
    config = function(_, _)
        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
        vim.keymap.set("n", "<leader>pg", builtin.live_grep, {})
        vim.keymap.set("n", "<C-p>", builtin.git_files, {})
    end,
}
