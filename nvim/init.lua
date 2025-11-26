-- ~/.config/nvim/init.lua

-- =============================================================================
-- 1. LAZY.NVIM BOOTSTRAP (Plugin Manager)
--    Installeert lazy.nvim automatisch als het niet gevonden wordt.
-- =============================================================================

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

-- =============================================================================
-- 2. BASISINSTELLINGEN (vim.opt)
--    Standaard opties voor een goede editor-ervaring.
-- =============================================================================

vim.g.mapleader = " " -- Stel de <leader> key in op Spatie (erg belangrijk!)
vim.g.maplocalleader = " "

vim.opt.number = true         -- Regelnummers
vim.opt.relativenumber = true -- Relatieve regelnummers
vim.opt.mouse = "a"           -- Muis-ondersteuning
vim.opt.ignorecase = true     -- Case-insensitive zoeken
vim.opt.smartcase = true      -- ...tenzij er een hoofdletter in zit
vim.opt.hlsearch = true       -- Highlight zoekresultaten
vim.opt.incsearch = true      -- Incrementeel zoeken
vim.opt.tabstop = 4           -- Tabs zijn 4 spaties
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true      -- Gebruik spaties i.p.v. tabs
vim.opt.scrolloff = 8         -- Behoud 8 regels context boven/onder cursor
vim.opt.clipboard = "unnamedplus" -- Gebruik systeemklembord
vim.opt.breakindent = true    -- Behoud indentatie bij soft-wrap
vim.opt.wrap = false          -- Geen soft-wrap (persoonlijke voorkeur)
vim.opt.termguicolors = true  -- Essentieel voor moderne colorschemes
vim.opt.signcolumn = "yes"    -- Altijd de signcolumn tonen (voor LSP, git signs)

-- =============================================================================
-- 3. PLUGINS (lazy.nvim setup)
--    Hier definiëren we alle plugins die we willen gebruiken.
-- =============================================================================

-- HIER BEGINT DE CALL (regel ~52)
require("lazy").setup({
  
  -- Thema
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} },

  -- Discord Integration
  { "vyfor/cord.nvim", event = "VeryLazy" },

  -- Statusline
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

  -- File Explorer
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
  
  -- Syntax Highlighting (beter dan de standaard)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  
  -- Git integratie
  { "lewis6991/gitsigns.nvim", opts = {} },
 
  { "kdheepak/lazygit.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  
  {
      'nvim-telescope/telescope.nvim',
      -- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' },

      opts = {
          defaults = {
              layout_strategy = 'vertical',
              layout_config = {
                  prompt_position = 'bottom',
                  height = 0.9,
              }
          }
        },
  },


  -- Autocompletion (nvim-cmp)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP-gebaseerde aanvullingen
      "hrsh7th/cmp-buffer",   -- Buffer-gebaseerde aanvullingen
      "L3MON4D3/LuaSnip",     -- Snippet engine
    }
  },

  -- LSP (Language Server Protocol) Stack
  -- Dit is de *belangrijkste* set plugins voor een programmeur.
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      -- LSP Management
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      
      -- Autocompletion (zie hierboven)
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
    }
  },

  -- Session persistence
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
  },

 }) -- <-- HIER IS DE CORRECTE AFSLUITING (rond regel ~155)

-- =============================================================================
-- 4. PLUGIN CONFIGURATIE
--    We hebben de plugins geladen, nu configureren we ze.
-- =============================================================================

-- 4.1. Thema (TokyoNight)
vim.cmd.colorscheme "tokyonight-storm"

-- 4.2. LspZero (Vereenvoudigt LSP & CMP setup)
local lsp_zero = require("lsp-zero")
lsp_zero.on_attach(function(client, bufnr)
  -- Keymaps specifiek voor LSP (in dit buffer)
  -- Zie `:help lsp-zero-keybindings` voor een volledige lijst
  lsp_zero.default_keymaps({buffer = bufnr})

local kmap_opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, kmap_opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, kmap_opts)
  vim.keymap.set('n', 'gr', '<Cmd>Telescope lsp_references<CR>', kmap_opts)
  
end)
-- Dit stelt automatisch Mason, lspconfig en nvim-cmp in.
require("lsp-zero").preset("recommended")
require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = { 
    "lua_ls",
    "ts_ls",
    "pyright",
    "rust_analyzer",
    "gopls",
    "intelephense"
  },
  handlers = {
    lsp_zero.default_setup,
  },
})


-- 4.3. Treesitter (Syntax Highlighting)
require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "typescript", "python", "rust", "go", "bash" },
  auto_install = true, -- Installeer automatisch parsers als je een nieuw bestandstype opent
  highlight = {
    enable = true,
  },
})

-- 4.4. Nvim-Tree (File Explorer)
require("nvim-tree").setup({})

-- =============================================================================
-- 5. KEYMAPS (Sneltoetsen)
--    Definieer je eigen sneltoetsen.
-- =============================================================================
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Modes:
--   'n': Normal mode
--   'i': Insert mode
--   'v': Visual mode

-- Navigatie
keymap("n", "<leader>pv", ":NvimTreeToggle<CR>", opts) -- "Project View" (File Explorer)

-- Telescope (Fuzzy Finder)
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts) -- "Find Files"
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)  -- "Find Grep" (zoek tekst in project)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)   -- "Find Buffers"
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)  -- "Find Help"
keymap("n", "<leader>gg", ":Lazygit<CR>", opts) -- "Lazygit"
keymap("n", "<leader>fd", ":Telescope diagnostics<CR>", opts) -- "Find Diagnostics" (Project Fouten)

-- LSP Keymaps (via lsp-zero, de meeste zijn al ingesteld)
-- De belangrijkste:
-- gd: Ga naar definitie (Go to Definition)
-- K: Toon documentatie (Hover)
-- <leader>ca: Code Action
-- <leader>rn: Rename
