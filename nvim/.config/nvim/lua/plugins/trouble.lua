return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    cmd = { "Trouble" },
    keys = {
      { "<leader>xx", function()
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
      end, desc = "Toggle diagnostics" },
      { "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Workspace diagnostics" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>",                   desc = "Location list" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix list" },
    },
  },
}
