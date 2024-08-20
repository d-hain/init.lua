return {
    -- Git
    { "airblade/vim-gitgutter" }, -- git diff icons in lines

    -- QoL
    {
        "kylechui/nvim-surround",
        config = function(_, _)
            require("nvim-surround").setup {}
        end
    },
    { "alvan/vim-closetag" },

    {
        "seandewar/nvimesweeper",
        config = function(_, _)
            vim.g.nvimesweeper_size = 10
        end
    },
}
