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

require("lazy").setup("plugins")

require("config.keymaps")

require("config.codex")

require("config.codex_extras")

require("config.projects")

require("config.run")

require("config.term")

require("config.trouble")

require("config.diagnostics")

require("config.theme").load()
