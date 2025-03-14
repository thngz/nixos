require('keybinds')

vim.wo.relativenumber = true
vim.opt.termguicolors = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.ignorecase = true
vim.opt.autoindent = true;

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

require("lazy").setup("plugins")
require('harels')

vim.cmd('colorscheme modus-vivendi')
