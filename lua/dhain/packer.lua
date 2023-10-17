vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"

    -- Beautiful colors
    use "navarasu/onedark.nvim"
    use {
        "nvim-treesitter/nvim-treesitter",
        tag = "0.9.0",
        {
            run = ":TSUpdate"
        },
    }
    use "brenoprata10/nvim-highlight-colors"
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        -- TODO:
        -- FIX:
        -- HACK:
        -- WARN:
        -- PERF:
        -- NOTE:
        -- TEST:
        -- FIXME:
    }
    use "RRethy/vim-illuminate"

    -- Better than netrw
    use {
        "nvim-tree/nvim-tree.lua",
        requires = "nvim-tree/nvim-web-devicons",
    }

    -- Lualine
    use {
        "nvim-lualine/lualine.nvim",
        requires = {
            "kyazdani42/nvim-web-devicons",
            opt = true
        },
    }

    -- Blazingly fast navigation
    use "theprimeagen/harpoon"
    use {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        requires = "nvim-lua/plenary.nvim",
    }

    -- Git things
    use "tpope/vim-fugitive"
    use "airblade/vim-gitgutter" -- git diff icons in lines

    -- The Vim GOD
    use "tpope/vim-commentary"

    -- (sadly) a little better than from the Vim GOD. ):
    use {
        "kylechui/nvim-surround",
        tag = "*",
    }

    -- QoL
    use "windwp/nvim-autopairs"
    use "alvan/vim-closetag"
    use "nvim-treesitter/nvim-treesitter-context"

    -- Useful things
    use "mbbill/undotree"
    use {
        "nvim-treesitter/playground",
        requires = "nvim-treesitter",
    }

    -- Markdown preview
    use {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    }

    -- LSP
    use {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            {
                "williamboman/mason.nvim",
                run = function()
                    pcall(vim.cmd, "MasonUpdate")
                end,
            },
            {
                "williamboman/mason-lspconfig.nvim",
                tag = "v1.12.0"
            },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" }, -- Required
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "hrsh7th/cmp-nvim-lua" }, -- Required

            -- Snippets
            { "L3MON4D3/LuaSnip" }, -- Required
            { "rafamadriz/friendly-snippets" },

            -- Better than quickfix list
            {
                "folke/trouble.nvim",
                requires = { "nvim-tree/nvim-web-devicons" },
            }
        },
    }
    -- TODO: Find a good plugin for Rust Crates

    use "github/copilot.vim"

    -- Very important
    use "andweeb/presence.nvim" -- Discord Integration
    use "eandrju/cellular-automaton.nvim"
    use "tjdevries/sPoNGe-BoB.NvIm"
end)
