return {
    "rluba/jai.vim",
    ft = { "jai" },
    config = function(_, _)
        vim.b.jai_indent_options = { case_labels = 0 }
    end
}
