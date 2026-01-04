local k = vim.keymap.set

k("n", "<leader>xx", function()
  local ok, trouble = pcall(require, "trouble")
  if ok then
    trouble.toggle({ mode = "diagnostics" })
  else
    vim.cmd("Lazy load trouble.nvim")
    vim.defer_fn(function()
      local ok2, trouble2 = pcall(require, "trouble")
      if ok2 then trouble2.toggle({ mode = "diagnostics" }) end
    end, 50)
  end
end, { silent = true })

k("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", { silent = true })
k("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { silent = true })
k("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { silent = true })
k("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { silent = true })
