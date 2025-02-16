return {
    "mfussenegger/nvim-dap",
    dependencies = {
        { "rcarriga/nvim-dap-ui" },
        { "nvim-neotest/nvim-nio" },
        { "theHamsta/nvim-dap-virtual-text" },
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")
        require("nvim-dap-virtual-text").setup()
        dapui.setup()

        vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
        vim.fn.sign_define("DapLogPoint", { text = "📜", texthl = "DiagnosticWarn", linehl = "", numhl = "" })

        -- Dap UI Auto-Open / Close
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end


		require("Config.debugger.adapters.js_dap_adapter").configure_js_adapter()
		
        
    end,
}
