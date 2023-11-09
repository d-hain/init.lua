return {
    "tpope/vim-commentary",
    config = function(_, _)
        vim.api.nvim_create_autocmd(
            { "BufEnter", "BufWinEnter" },
            {
                pattern = "*.odin",
                callback = function(_)
                    vim.opt_local.commentstring = "// %s"
                end
            }
        )

        vim.api.nvim_create_autocmd(
            { "BufEnter", "BufWinEnter" },
            {
                pattern = "*.c",
                callback = function(_)
                    vim.opt_local.commentstring = "// %s"
                end
            }
        )
    end,
}
