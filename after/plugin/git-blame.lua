pcall(vim.cmd, "GitBlameDisable")

vim.keymap.set("n", "<leader>gb", "<cmd>GitBlameToggle<CR>")
