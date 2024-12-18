return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function(_, _)
        require("oil").setup {
            view_options = {
                show_hidden = true,
            }
        }

        vim.keymap.set("n", "<leader>pv", "<cmd>Oil<CR>")
    end
}
