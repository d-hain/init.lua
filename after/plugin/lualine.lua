require("lualine").setup {
    options = {
        icons_enabled = true,
        theme = "palenight",
    },
    sections = {
        lualine_b = {
            {
                "filename",
                path = 4
            }
        }
    }
}
