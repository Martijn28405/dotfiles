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

require("lazy").setup({
  spec = {
    -- Theme & UI
    { import = "plugins.themes" },
    { import = "plugins.lualine" },
    { import = "plugins.bufferline" },
    { import = "plugins.ui" },

    -- Navigation
    { import = "plugins.telescope" },
    { import = "plugins.neo-tree" },
    { import = "plugins.oil" },
    { import = "plugins.project" },

    -- Editing
    { import = "plugins.cmp" },
    { import = "plugins.editor" },
    { import = "plugins.harpoon" },
    { import = "plugins.99" },

    -- Code
    { import = "plugins.treesitter" },
    { import = "plugins.lsp" },
    { import = "plugins.format" },
    { import = "plugins.lint" },
    { import = "plugins.trouble" },

    -- Git & workflow
    { import = "plugins.git" },
    { import = "plugins.session" },
    { import = "plugins.vim_blade" },
  },
})

require("config.keymaps")
require("config.theme").load()
