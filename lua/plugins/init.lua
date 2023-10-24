return {
    -- Colors
    {
        "brenoprata10/nvim-highlight-colors",
        config = function(_, _)
            require("nvim-highlight-colors").setup {}
        end
    },

    -- Git
    { "airblade/vim-gitgutter" }, -- git diff icons in lines

    -- QoL
    {
        "windwp/nvim-autopairs",
        config = function(_, _)
            require("nvim-autopairs").setup {}
        end
    },
    {
        "kylechui/nvim-surround",
        config = function(_, _)
            require("nvim-surround").setup {}
        end
    },
    { "alvan/vim-closetag" },
    { "nvim-treesitter/nvim-treesitter-context" },

    { "github/copilot.vim" },
    -- TODO: try out cody from sg.nvim
}
