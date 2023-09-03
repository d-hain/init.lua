vim.keymap.set("n", "<leader>carain", function ()
    pcall(vim.cmd, "CellularAutomaton make_it_rain")
end)

vim.keymap.set("n", "<leader>cagame", function ()
    pcall(vim.cmd, "CellularAutomaton game_of_life")
end)
