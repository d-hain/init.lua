return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function(_, _)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require("nvim-tree").setup {
            git = {
                enable = true,
                ignore = false,
            }
        }

        vim.keymap.set("n", "<leader>pv", "<cmd>NvimTreeFindFileToggle<CR>")
    end
}
