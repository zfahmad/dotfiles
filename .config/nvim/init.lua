local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.g.maplocalleader = ","
vim.g.mapleader = ","

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

require("config.keymaps")
require("lazy").setup("plugins")
require("config.options")
