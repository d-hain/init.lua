return {
    "folke/todo-comments.nvim",
    config = function(_, _)
        -- TODO:
        -- FIX:
        -- HACK:
        -- WARN:
        -- PERF:
        -- NOTE:
        -- TEST:

        require("todo-comments").setup {
            keywords = {
                HACK = {
                    alt = { "TEMP" }
                },
                PERF = {
                    color = "#ba9bf7",
                },
                NOTE = {
                    color = "#10b880",
                },
            }
        }

        vim.keymap.set("n", "<leader>td", "<cmd>TodoTelescope initial_mode=normal<CR>")
    end
}
