-- Cursor is always thick
vim.opt.guicursor = ""

-- Display eol, tabs and trailing spaces
-- Tabs: ▸
vim.opt.listchars = { eol = "↲", tab = "  ", trail = "·" }
vim.opt.list = true

-- Always display sign column
vim.opt.signcolumn = "yes"

-- Ignore case for searching with /
vim.opt.ignorecase = true

-- 100 character line
vim.opt.colorcolumn = "120"

-- Line Numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Indenting and Wrap
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- Undo Tree instead of Backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.g.mapleader = " "
