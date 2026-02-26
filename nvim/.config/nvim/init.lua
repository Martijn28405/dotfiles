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

require("config.options")
require("config.clipboard")

-- Explicit plugin groups keep the setup easy to scan and maintain.
require("lazy").setup({
  spec = {
    -- UI / look & feel
    { import = "plugins.themes" },
    { import = "plugins.ui" },
    { import = "plugins.aesthetics" },
    { import = "plugins.dashboard" },
    { import = "plugins.lualine" },
    { import = "plugins.polish" },

    -- Navigation / search / projects
    { import = "plugins.telescope" },
    { import = "plugins.navigation" },
    { import = "plugins.project" },
    { import = "plugins.oil" },

    -- Editing / productivity
    { import = "plugins.cmp" },
    { import = "plugins.productivity" },
    { import = "plugins.tools" },

    -- Code quality / language support
    { import = "plugins.treesitter" },
    { import = "plugins.lsp" },
    { import = "plugins.format" },
    { import = "plugins.lint" },
    { import = "plugins.trouble" },

    -- Workflow integrations
    { import = "plugins.git" },
    { import = "plugins.debug" },
    { import = "plugins.test" },
    { import = "plugins.session" },
    { import = "plugins.db" },
    { import = "plugins.vim_blade" },
    { import = "plugins.fun" },
  },
})

require("config.keymaps")
require("config.format")
require("config.projects")
require("config.trouble")
require("config.diagnostics")
require("config.theme").load()
