return {
    "tpope/vim-commentary",
    config = function(_, _)
        vim.api.nvim_create_autocmd(
            { "BufEnter", "BufWinEnter" },
            {
                pattern = "*.odin",
                callback = function(ev)
                    vim.opt_local.commentstring = "// %s"
                end
            }
        )
    end,
}
