function ColorMyPencils(color)
    if (color) then
        vim.cmd.colorscheme(color)
    else
        require("onedark").setup {
            style = "cool"
        }
        require("onedark").load()
    end

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
end

ColorMyPencils()
