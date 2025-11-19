return {
    "nvim-telescope/telescope.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function(_, _)
        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>pf", function()
            builtin.find_files {
                hidden = true,
                no_ignore = true,
                no_ignore_parent = true,
            }
        end, {})
        vim.keymap.set("n", "<leader>pg", builtin.live_grep, {})

        -- Visual Studio - hell yeah
        vim.keymap.set("n", "<C-S-f>", function()
            local word = vim.fn.expand("<cword>")
            builtin.live_grep {
                default_text = word
            }
        end)
        vim.keymap.set("v", "<C-S-f>", function()
            vim.cmd('normal! "zy')
            local selection = vim.fn.getreg("z")
            builtin.live_grep {
                default_text = selection
            }
        end)
    end,
}
