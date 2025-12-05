-- ~/.config/nvim/init.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

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
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

require("lazy").setup({
  
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} },

  { "vyfor/cord.nvim", event = "VeryLazy" },

  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
  
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },

  {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {}
},
  
  { "lewis6991/gitsigns.nvim", opts = {} },
 
 {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    lazy = true, 
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },  
  {
      'nvim-telescope/telescope.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },

      opts = {
          defaults = {
              layout_strategy = 'vertical',
              layout_config = {
                  prompt_position = 'bottom',
                  height = 0.9,
              }
          },
        },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
    }
  },

  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
    }
  },

  {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
  keys = {
    { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
  },
}
})

require('telescope').setup({
    defaults = {
        -- Deze defaults zijn er voor andere pickers die 'file_finder_cmd' gebruiken,
        -- en als fallback.
        file_finder_cmd = { 
            'fd', 
            '--type', 'f', 
            '--hidden', 
            '--no-ignore-vcs'
        },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
            '--no-ignore-vcs',
        },
        file_ignore_patterns = {},
    },
    
    -- DEZE SECTIE IS CRUCIAAL VOOR find_files
    pickers = {
        find_files = {
            -- Dwingt de find_files picker om deze specifieke finder command te gebruiken
            find_command = {
                'fd',
                '--type', 'f',
                '--hidden',
                '--no-ignore-vcs'
            },
        },
    },
})

vim.cmd.colorscheme "tokyonight-storm"

local lsp_zero = require("lsp-zero")
lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})

local kmap_opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, kmap_opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, kmap_opts)
  vim.keymap.set('n', 'gr', '<Cmd>Telescope lsp_references<CR>', kmap_opts)
end)
require("lsp-zero").preset("recommended")
require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = { 
    "lua_ls",
    "ts_ls",
    "pyright",
    "rust_analyzer",
    "gopls",
    "intelephense",
    "csharp-language-server"
  },
  handlers = {
    lsp_zero.default_setup,
  },
})

require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "typescript", "python", "rust", "go", "bash" },
  auto_install = true,
  highlight = {
    enable = true,
  },
})

require("nvim-tree").setup({})

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<leader>pv", ":NvimTreeToggle<CR>", opts)

keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap("n", "<leader>fd", ":Telescope diagnostics<CR>", opts)

keymap("n", "<leader>fm", function()
  vim.lsp.buf.format()
end, opts)
