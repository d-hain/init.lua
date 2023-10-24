return {
    "eandrju/cellular-automaton.nvim",
    config = function(_, _)
        vim.keymap.set("n", "<leader>carain", ":CellularAutomaton make_it_rain<CR>")
        vim.keymap.set("n", "<leader>cagame", ":CellularAutomaton game_of_life<CR>")
    end,
}

