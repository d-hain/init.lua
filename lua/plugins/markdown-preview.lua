return {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    config = function(_, _)
        vim.g.mkdp_theme = "light"
    end
}
