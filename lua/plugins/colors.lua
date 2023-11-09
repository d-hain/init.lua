return {
    "navarasu/onedark.nvim",
    priority = 10000,
    config = function()
        vim.cmd([[colorscheme onedark]])

        require("onedark").setup {
            style = "cool"
        }
        require("onedark").load()

        -- Transparent background
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
    end,
}
