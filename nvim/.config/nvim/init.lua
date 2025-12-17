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

  



{
  "vyfor/cord.nvim",
  event = "VeryLazy",
  opts = (function()
    local markers = {
      ".git",
      "package.json",
      "pyproject.toml",
      "Cargo.toml",
      "*.sln",
      "*.csproj",
    }

    local function workspace_name()
      local cwd = vim.fn.getcwd()
      local root = vim.fs.root(0, markers) or cwd
      return vim.fn.fnamemodify(root, ":t")
    end

    local function diag_counts()
      local bufnr = vim.api.nvim_get_current_buf()
      local diags = vim.diagnostic.get(bufnr)
      local e, w = 0, 0
      for _, d in ipairs(diags) do
        if d.severity == vim.diagnostic.severity.ERROR then e = e + 1 end
        if d.severity == vim.diagnostic.severity.WARN then w = w + 1 end
      end
      return e, w
    end

    local function ro_suffix(opts)
      return opts.is_read_only and " (read-only)" or ""
    end

    local function is_telescope()
      local ft = vim.bo.filetype
      return ft == "TelescopePrompt" or ft == "TelescopeResults"
    end

    local function is_lazy()
      return vim.bo.filetype == "lazy"
    end

    local function is_lazygit()
      if vim.bo.filetype == "lazygit" then return true end
      local ok, job = pcall(function() return vim.b.terminal_job_id end)
      if ok and job then
        local info = vim.fn.jobinfo(job)
        local cmd = info and info.cmd
        if type(cmd) == "table" then cmd = table.concat(cmd, " ") end
        if type(cmd) == "string" and cmd:lower():find("lazygit", 1, true) then
          return true
        end
      end
      return false
    end

    local function terminal_activity()
      local ok, job = pcall(function() return vim.b.terminal_job_id end)
      if not (ok and job) then return nil end

      local info = vim.fn.jobinfo(job)
      local cmd = info and info.cmd
      if type(cmd) == "table" then cmd = table.concat(cmd, " ") end
      if type(cmd) ~= "string" then return nil end
      local c = cmd:lower()

      if c:find("dotnet build", 1, true) then return "Building. Expecting disappointment." end
      if c:find("dotnet test", 1, true) then return "Running tests. Awaiting judgement." end
      if c:find("dotnet run", 1, true) then return "Running the app. Watching it closely." end

      return nil
    end

    return {
      text = {
        workspace = function()
          return ("Somewhere inside %s"):format(workspace_name())
        end,

        editing = function(opts)
          if is_telescope() then
              if vim.g.cord_telescope_mode == "files" then
                return "Looking for a file. Any file."
              end
              if vim.g.cord_telescope_mode == "grep" then
                return "Searching text. Regretting past naming choices."
              end
              return "Searching. Confidently."
            end
              if is_lazy() then
                return "Installing more plugins. For stability."
              end
              if is_lazygit() then
                return "Using LazyGit. Decisions will be made."
              end

          local e, w = diag_counts()
          local ro = ro_suffix(opts)

          if e > 0 then
            if e == 1 then
              return ("Putting out one fire in %s%s"):format(opts.filename, ro)
            end
            return ("Putting out %d fires in %s%s"):format(e, opts.filename, ro)
          end

          if w > 0 then
            if w == 1 then
              return ("Ignoring one warning in %s%s"):format(opts.filename, ro)
            end
            return ("Ignoring %d warnings in %s%s"):format(w, opts.filename, ro)
          end

          return ("Editing %s%s (no fires today)"):format(opts.filename, ro)
        end,

        viewing = function(opts)
          if is_telescope() then
              if vim.g.cord_telescope_mode == "files" then
                return "Found files. Choosing poorly."
              end
              if vim.g.cord_telescope_mode == "grep" then
                return "Search results. The culprit is nearby."
              end
              return "Results. Surely correct."
            end
          if is_lazy() then return "Reading plugin descriptions." end
          if is_lazygit() then return "Reviewing history. Regretting it." end
          return ("Staring at %s%s"):format(opts.filename, ro_suffix(opts))
        end,

        terminal = function()
          if is_lazygit() then return "Using LazyGit. Decisions will be made." end
          return terminal_activity() or "Typing commands carefully."
        end,

       
        file_browser = function()
          if vim.g.cord_telescope_mode == "files" then
            return "Looking for a file. Any file."
          end
          if vim.g.cord_telescope_mode == "grep" then
            return "Searching text. Regretting past naming choices."
          end
          return "Searching for something. Not sure what."
        end,
        plugin_manager = "Installing more plugins. For stability.",
        vcs = "Negotiating with git.",
      },

      idle = {
        smart_idle = true,
        details = "Thinking about a better approach.",
      },

      buttons = {
        { label = "Neovim", url = "https://neovim.io" },
      },

      advanced = {
        plugin = {
          cursor_update = "on_move",
        },
        workspace = {
          root_markers = markers,
        },
      },
    }
  end)(),
},


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


local tb = require("telescope.builtin")

keymap("n", "<leader>ff", function()
  vim.g.cord_telescope_mode = "files"
  tb.find_files()
end, opts)

keymap("n", "<leader>fg", function()
  vim.g.cord_telescope_mode = "grep"
  tb.live_grep()
end, opts)

keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap("n", "<leader>fd", ":Telescope diagnostics<CR>", opts)

keymap("n", "<leader>fm", function()
  vim.lsp.buf.format()
end, opts)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    vim.api.nvim_create_autocmd("BufWipeout", {
      buffer = 0,
      once = true,
      callback = function()
        vim.g.cord_telescope_mode = nil
      end,
    })
  end,
})

