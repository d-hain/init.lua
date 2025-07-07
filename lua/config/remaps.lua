-- Yank to system clipboard
vim.keymap.set("v", "<leader>y", '"+y')

-- Redo remap
vim.keymap.set("n", "U", "<C-r>")

-- Save
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<CR>a")

-- Netrw
-- Open in cwd
vim.keymap.set("n", "<leader>pv", function()
    vim.cmd("Ex " .. vim.fn.getcwd())
end)
-- Open in current file's location
vim.keymap.set("n", "<leader>pw", ":Explore<CR>")
-- Keybinds in netrw
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        vim.keymap.set("n", "h", "-", { buffer = true, remap = true })
        vim.keymap.set("n", "l", "<CR>", { buffer = true, remap = true })
        vim.keymap.set("n", "<Esc>", function()
            vim.cmd("bprevious")
        end, { buffer = true })
    end
})

-- Window movement without C-w
vim.keymap.set("n", "<C-S-h>", "<C-w>h")
vim.keymap.set("n", "<C-S-j>", "<C-w>j")
vim.keymap.set("n", "<C-S-k>", "<C-w>k")
vim.keymap.set("n", "<C-S-l>", "<C-w>l")

-- Window resizing
vim.keymap.set("n", "<C-A-z>", "<c-w>5<")
vim.keymap.set("n", "<C-A-i>", "<C-W>-")
vim.keymap.set("n", "<C-A-u>", "<C-W>+")
vim.keymap.set("n", "<C-A-o>", "<c-w>5>")

-- Moving Selections/Lines
vim.keymap.set("v", "<A-S-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-S-k>", ":m '<-2<cr>gv=gv")
vim.keymap.set("n", "<A-S-j>", ":m .+1<cr>==")
vim.keymap.set("n", "<A-S-k>", ":m .-2<CR>==")
vim.keymap.set("i", "<A-S-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<A-S-k>", "<Esc>:m .-2<CR>==gi")

-- Half page jump and searching -> center cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Undo highlight search done by using '*'
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Align equal signs
vim.keymap.set("v", "<C-0>", "<Esc>:'<,'> ! column -t -s= -o= | sed 's/=/ = /g'<CR>")

-- Exit Terminal Mode using Esc
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

local terminal = require("terminal")
-- Open a floating Terminal and build the project using a specified command (default: make)
-- Command is customizable using a .nvim.lua file in the project directory
vim.keymap.set("n", "<C-b>", terminal.open_float_term)

-- Floating terminal -> split terminal
vim.keymap.set("n", "<A-b>", terminal.float_to_split_term)
vim.keymap.set("t", "<A-b>", terminal.float_to_split_term)
