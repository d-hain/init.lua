local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({})

-- Fix Undefined global 'vim'
lsp.configure("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

-- On every buffer that uses an lsp
lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }
    local lspconfig = require("lspconfig")

    -- Intelephense folder not in home directory
    lspconfig.intelephense.setup {
        init_options = {
            globalStoragePath = os.getenv("HOME") .. "/.local/share/intelephense"
        }
    }

    vim.lsp.handlers["textDocument/signature_help"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
            border = "rounded",
            close_events = { "CursorMoved", "BufHidden", "InsertCharPre" }
        }
    )

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<C-n>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("i", "<C-n>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>vnd", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<leader>vpd", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)

    local trouble = require("trouble")

    vim.keymap.set("n", "<leader>vwd", function() trouble.open("workspace_diagnostics") end, opts)
    vim.keymap.set("n", "<leader>vad", function() trouble.open("document_diagnostics") end, opts)
    vim.keymap.set("n", "<leader>vrr", function() trouble.open("lsp_references") end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
