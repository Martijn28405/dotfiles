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
    { import = "plugins.themes" },
    { import = "plugins.telescope" },
    { import = "plugins.treesitter" },
    { import = "plugins.lsp" },
    { import = "plugins.cmp" },
    { import = "plugins.format" },
    { import = "plugins.trouble" },
    { import = "plugins.harpoon" },
    { import = "plugins.undotree" },
    { import = "plugins.fugitive" },
    { import = "plugins.git" },
    { import = "plugins.99" },
  },
})

require("config.keymaps")
require("config.trouble")
require("config.diagnostics")
require("config.theme").load()
