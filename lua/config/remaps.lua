-- Redo remap
vim.keymap.set("n", "U", "<C-r>")

-- Save
vim.keymap.set("n", "<C-a>", "<cmd>w<CR>")
vim.keymap.set("i", "<C-a>", "<Esc><cmd>w<CR>a")

-- Window movement without C-w
vim.keymap.set("n", "<C-A-h>", "<C-w>h")
vim.keymap.set("n", "<C-A-j>", "<C-w>j")
vim.keymap.set("n", "<C-A-k>", "<C-w>k")
vim.keymap.set("n", "<C-A-l>", "<C-w>l")

-- Moving Selections/Lines
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv")
vim.keymap.set("n", "<A-j>", ":m .+1<cr>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Half page jump and searching -> center cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
