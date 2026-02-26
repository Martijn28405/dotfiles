return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("mason-nvim-dap").setup({
        ensure_installed = { "python", "delve", "js" },
        automatic_installation = true,
        handlers = {},
      })

      dapui.setup()

      -- Auto open/close UI on debug events
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      local map = vim.keymap.set
      map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      map("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Conditional breakpoint" })
      map("n", "<leader>dc", dap.continue, { desc = "Continue / start" })
      map("n", "<leader>dn", dap.step_over, { desc = "Step over" })
      map("n", "<leader>di", dap.step_into, { desc = "Step into" })
      map("n", "<leader>do", dap.step_out, { desc = "Step out" })
      map("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
      map("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
      map("n", "<leader>dl", dap.run_last, { desc = "Run last session" })
      map("n", "<leader>de", function()
        dapui.eval(nil, { enter = true })
      end, { desc = "Evaluate expression" })
    end,
  },
}
