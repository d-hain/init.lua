return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function(_, _)
        require("oil").setup()

        vim.keymap.set("n", "<leader>pv", "<cmd>Oil<CR>")
    end
}
