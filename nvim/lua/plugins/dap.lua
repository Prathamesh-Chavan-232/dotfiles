-- Debugging: nvim-dap + UI + virtual text. JS/TS via js-debug-adapter (mason).
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup()
    require("nvim-dap-virtual-text").setup()

    -- Auto open/close the DAP UI.
    dap.listeners.before.attach.dapui_config = dapui.open
    dap.listeners.before.launch.dapui_config = dapui.open
    dap.listeners.before.event_terminated.dapui_config = dapui.close
    dap.listeners.before.event_exited.dapui_config = dapui.close

    -- JS/TS adapter (pwa-node) from the mason js-debug-adapter package.
    local js_debug = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = { command = "node", args = { js_debug, "${port}" } },
    }
    for _, ft in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
      dap.configurations[ft] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch current file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to process",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end

    local map = vim.keymap.set
    map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Breakpoint toggle" })
    map("n", "<leader>dc", dap.continue, { desc = "Continue" })
    map("n", "<leader>di", dap.step_into, { desc = "Step into" })
    map("n", "<leader>do", dap.step_over, { desc = "Step over" })
    map("n", "<leader>dO", dap.step_out, { desc = "Step out" })
    map("n", "<leader>dr", dap.repl.toggle, { desc = "REPL toggle" })
    map("n", "<leader>du", dapui.toggle, { desc = "DAP UI toggle" })
    map("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
  end,
}
