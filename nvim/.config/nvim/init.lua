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


local theme = require("config.theme")

theme.load()

pcall(vim.cmd.colorscheme, "tokyonight-storm")

require("config.options")

require("config.clipboard")

require("lazy").setup("plugins")

require("config.keymaps")

require("config.codex")

require("config.lualine")

require("config.codex_extras")

require("config.projects")

require("config.run")

require("config.trouble")

require("config.diagnostics")
