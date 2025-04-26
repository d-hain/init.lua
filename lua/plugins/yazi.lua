return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {
        "folke/snacks.nvim",
    },

    opts = {
        -- open yazi instead of netrw
        open_for_directories = true,
        floating_window_scaling_factor = 1.0,
        yazi_floating_window_border = "none",
    },

    keys = {
        {
            "<leader>pw",
            mode = { "n", "v" },
            "<cmd>Yazi<cr>",
            desc = "Open yazi at the current file",
        },
        {
            "<leader>pv",
            "<cmd>Yazi cwd<cr>",
            desc = "Open the file manager in nvim's working directory",
        },
    },
}
