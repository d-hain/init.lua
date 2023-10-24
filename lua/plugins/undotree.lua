return {
    "mbbill/undotree",
    config = function(_, _)
        vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
    end,
}
