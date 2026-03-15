vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.guicursor = ""          -- block cursor in all modes (Prime style)

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.hlsearch = false        -- no persistent search highlight
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"      -- ruler at 80 chars

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.isfname:append("@-@")  -- allow @ and - in filenames

-- Performance
vim.opt.updatetime = 50        -- snappier diagnostics & gitsigns
vim.opt.synmaxcol  = 240       -- don't highlight beyond 240 chars/line
vim.opt.redrawtime = 1500      -- abort slow syntax highlighting rather than freezing

