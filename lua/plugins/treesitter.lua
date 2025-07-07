return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        dependencies = {
            -- NOTE: nvim-treesitter needs to be loaded after markview.nvim
            -- Needs "markdown" and "markdown_inline" treesitter parsers
            "OXY2DEV/markview.nvim",
            lazy = true,
            ft = { "md" },
            opts = {
                markdown = {
                    code_blocks = {
                        style = "simple",
                    },
                },
                typst = {
                    enable = false,
                },
            },
        },
        config = function(_, _)
            require("nvim-treesitter.configs").setup {
                -- A list of parser names, or "all" (the five listed parsers should always be installed)
                ensure_installed = {
                    "c", "rust", "java", "javascript", "typescript",
                    "lua", "vim", "vimdoc", "query",
                },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                auto_install = true,

                highlight = {
                    enable = true,

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },

                indent = {
                    enable = true,
                },
            }
        end,
    },

    { "nvim-treesitter/nvim-treesitter-context" },

    -- For filetypes like Vue and Svelte
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function(_, _)
            require("ts_context_commentstring").setup {}

            vim.g.skip_ts_context_commentstring_module = true

            -- NOTE: automatically has integration with tpope/vim-commentary
        end
    }
}
