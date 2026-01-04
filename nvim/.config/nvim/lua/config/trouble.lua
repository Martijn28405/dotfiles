local k = vim.keymap.set
k("n", "<leader>xx", "<cmd>Trouble toggle<cr>", { silent = true })
k("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", { silent = true })
k("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { silent = true })
k("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { silent = true })
k("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { silent = true })
