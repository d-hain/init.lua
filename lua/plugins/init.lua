return {
    -- Colors
    -- {
    --     "brenoprata10/nvim-highlight-colors",
    --     config = function(_, _)
    --         require("nvim-highlight-colors").setup {}
    --     end
    -- },

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
    { "nvim-treesitter/nvim-treesitter-context" },

    { "github/copilot.vim" },
    {
        "seandewar/nvimesweeper",
        config = function(_, _)
            vim.g.nvimesweeper_size = 10
        end
    },
}
