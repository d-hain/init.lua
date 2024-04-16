return {
    "tpope/vim-fugitive",
    config = function(_, _)
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        vim.keymap.set("n", "<leader>gb", ":Git blame<CR>")
    end
}
