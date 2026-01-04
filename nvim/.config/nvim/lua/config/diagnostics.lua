vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
    prefix = "●",
    severity = { min = vim.diagnostic.severity.WARN },
    source = "if_many",
  },
  signs = true,
  underline = true,
  severity_sort = true,
  update_in_insert = false,
  float = {
    border = "rounded",
    source = "if_many",
  },
})
