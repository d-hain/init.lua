return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-vsnip",

            -- Snippets
            "hrsh7th/vim-vsnip",
            "SirVer/ultisnips",
            "quangnguyen30192/cmp-nvim-ultisnips",
        },
        config = function(_, _)
            local cmp = require("cmp")

            -- require("cmp_nvim_ultisnips").setup()
            -- local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

            cmp.setup {
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert {
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-y>"] = cmp.mapping.confirm { select = true },
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<Tab>"] = cmp.config.disable,
                    ["<S-Tab>"] = cmp.config.disable,
                },
                sources = cmp.config.sources {
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "buffer" },
                    { name = "path" },

                    { name = "ultisnips" },
                    { name = "vsnip" },
                }, {
                { name = "buffer" },
            }
            }

            -- Set configuration for specific filetype.
            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({
                    { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
                }, {
                    { name = "buffer" },
                })
            })

            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline("/", {
                sources = {
                    { name = "buffer" }
                }
            })

            -- Use cmdline & path source for ":" (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(":", {
                sources = cmp.config.sources({
                    { name = "path" }
                }, {
                    { name = "cmdline" }
                })
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        version = "0.1.7",
        dependencies = {
            {
                "folke/trouble.nvim",
                dependencies = "nvim-tree/nvim-web-devicons"
            },
            {
                "ray-x/lsp_signature.nvim",
                config = function(_, opts)
                    require("lsp_signature").setup {
                        hint_prefix = "",
                        floating_window = false,
                        bind = true,
                        opts = opts,
                    }
                end
            },
            {
                "williamboman/mason.nvim",
                version = "v1.8.3",
                config = function(_, _)
                    require("mason").setup()
                end
            },
            {
                "williamboman/mason-lspconfig.nvim",
                version = "v1.17.0",
            },
        },
        config = function(_, _)
            local ts_utils = require("nvim-treesitter.ts_utils")
            local locals = require("nvim-treesitter.locals")
            local utils = require("nvim-treesitter.utils")

            local get_node_text = vim.treesitter.get_node_text or vim.treesitter.query.get_node_text
            local M = {}

            -- NOTE: yoinked from https://github.com/nvim-treesitter/nvim-treesitter-refactor/tree/65ad2eca822dfaec2a3603119ec3cc8826a7859e
            function M.smart_rename(bufnr)
                bufnr = bufnr or vim.api.nvim_get_current_buf()
                local node_at_point = ts_utils.get_node_at_cursor()
                local function complete_rename(new_name)
                    -- Empty name cancels the interaction or ESC
                    if not new_name or #new_name < 1 then
                        return
                    end

                    local definition, scope = locals.find_definition(node_at_point, bufnr)
                    local nodes_to_rename = {}
                    nodes_to_rename[node_at_point:id()] = node_at_point
                    nodes_to_rename[definition:id()] = definition

                    for _, n in ipairs(locals.find_usages(definition, scope, bufnr)) do
                        nodes_to_rename[n:id()] = n
                    end

                    local edits = {}

                    for _, node in pairs(nodes_to_rename) do
                        local lsp_range = ts_utils.node_to_lsp_range(node)
                        local text_edit = { range = lsp_range, newText = new_name }
                        table.insert(edits, text_edit)
                    end
                    vim.lsp.util.apply_text_edits(edits, bufnr, "utf-8")
                end

                if not node_at_point then
                    utils.print_warning "No node to rename!"
                    return
                end

                local node_text = get_node_text(node_at_point, bufnr)
                local input = { prompt = "New name: ", default = node_text or "" }
                if not vim.ui.input then
                    local new_name = vim.fn.input(input.prompt, input.default)
                    complete_rename(new_name)
                else
                    vim.ui.input(input, complete_rename)
                end
            end

            local lspconfig = require("lspconfig")

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
            capabilities.offsetEncoding = { "utf-16" }
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            -- NOTE: yanked from https://github.com/jdah/dotfiles and I have no idea what it does
            capabilities.textDocument.completion.completionItem.resolveSupport = {
                properties = { "documentation", "detail", "additionalTextEdits" },
            }

            require("mason-lspconfig").setup_handlers {
                -- Setup all installed LSP servers with the nvim-cmp capabilities.
                function(server)
                    lspconfig[server].setup { capabilities = capabilities }
                end,
                ["lua_ls"] = function()
                    -- Fix undefined global 'vim' warning.
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" }
                                }
                            }
                        },
                    }
                end,
                -- clangd setup
                ["clangd"] = function()
                    lspconfig.clangd.setup {
                        capabilities = capabilities,
                        cmd = {
                            "clangd",
                            "--pch-storage=memory",
                            "--completion-style=detailed",
                            "--header-insertion=never",

                            "--background-index",
                            "--all-scopes-completion",
                            "--header-insertion-decorators",
                            "--function-arg-placeholders",
                            "--inlay-hints",
                            "--pretty",
                            -- TODO: remove or adjust
                            -- "-j=4",
                        },
                        filetypes = { "c", "cpp", "objc", "objcpp" },
                        root_dir = lspconfig.util.root_pattern("src"),
                    }
                end,
                ["ols"] = function()
                    lspconfig.ols.setup {
                        capabilities = capabilities,
                        root_dir = vim.loop.cwd,
                    }
                end,
            }

            -- Global mappings
            vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float)
            vim.keymap.set("n", "<leader>nd", vim.diagnostic.goto_next)
            vim.keymap.set("n", "<leader>pd", vim.diagnostic.goto_prev)

            -- LSP Buffer mappings
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(args)
                    local opts = { buffer = args.buf }
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    vim.lsp.handlers["textDocument/signature_help"] = vim.lsp.with(
                        vim.lsp.handlers.signature_help, {
                            border = "rounded",
                            close_events = { "CursorMoved", "BufHidden", "InsertCharPre" }
                        }
                    )

                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set({ "n", "i" }, "<C-n>", function()
                        require("lsp_signature").toggle_float_win()
                    end, opts)
                    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>rn", function()
                        if client.server_capabilities.renameProvider then
                            vim.lsp.buf.rename()
                        else
                            M.smart_rename(args.buf)
                        end
                    end, opts)
                    vim.keymap.set("n", "<leader>f", function()
                        if vim.bo.filetype == "json" then
                            vim.cmd("%!jq '.'")
                        else
                            vim.lsp.buf.format { async = true }
                        end
                    end, opts)

                    local trouble = require("trouble")

                    vim.keymap.set("n", "<leader>da", function() trouble.open("document_diagnostics") end, opts)
                    vim.keymap.set("n", "<leader>rr", function() trouble.open("lsp_references") end, opts)
                end,
            })
        end
    },
}
