return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "kyazdani42/nvim-web-devicons",
        name = "kyazdani42-web-devicons"
    },
    config = function(_, _)
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
    end
}
