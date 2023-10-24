return {
    "RRethy/vim-illuminate",
    config = function(_, _)
        require("illuminate").configure {
            filetypes_denylist = { "NvimTree" },
            min_count_to_highlight = 2,
        }

        -- Underlines as Highlights are awful
        vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#2c323c" })
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#2c323c" })
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#2c323c" })
    end,
}
