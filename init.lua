-- Setup lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("config.set")
require("lazy").setup("plugins", {
    defaults = {
        lazy = false,
    },
    install = {
        colorscheme = { "onedark" },
    }
})
require("config.remaps")

-- Shortcut to get to line and column
vim.api.nvim_create_user_command("Lc", function(opts)
    vim.api.nvim_win_set_cursor(0, { tonumber(opts.fargs[1]), tonumber(opts.fargs[2]) })
end, { nargs = "+" })

print("The One Piece ... THE ONE PIECE IS REEAAALLLL!!!")
