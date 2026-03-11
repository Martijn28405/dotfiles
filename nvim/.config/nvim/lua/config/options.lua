vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.scrolloff = 8
vim.opt.breakindent = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.swapfile = false

-- Performance
vim.opt.updatetime = 250   -- faster CursorHold → snappier diagnostics & gitsigns
vim.opt.synmaxcol  = 240   -- don't highlight beyond 240 chars/line (helps with minified files)
vim.opt.redrawtime = 1500  -- abort slow syntax highlighting rather than freezing

