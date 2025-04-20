return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {
        "folke/snacks.nvim",
    },

    opts = {
        -- open yazi instead of netrw
        open_for_directories = true,
        keymaps = {
            show_help = "<f1>",
        },
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
