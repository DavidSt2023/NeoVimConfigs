local local_js_based_languages = {
    "typescript",
    "javascript",
    "typescriptreact",
    "javascriptreact",
    "vue",
}

local dap_icons = {
    Breakpoint = { "🛑", "DiagnosticError" },
    Stopped = { "▶️", "DiagnosticInfo" },
    LogPoint = { "📜", "DiagnosticWarn" },
}

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "rcarriga/nvim-dap-ui" },
            { "nvim-neotest/nvim-nio" },
            { "theHamsta/nvim-dap-virtual-text" },
            { "microsoft/vscode-js-debug", build = "npm install --legacy-peer-deps && npx gulp dapDebugServer && mv dist out" },
            { "microsoft/vscode-chrome-debug" },
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()
			dap.set_log_level('DEBUG')
			--DapUi config
			local dap, dapui = require("dap"), require("dapui")
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

		  dap.adapters["pwa-chrome"] = {
			  type = 'executable',
			  command = 'node',
			  args = { vim.fn.resolve(vim.fn.stdpath("data")..'\\lazy\\vscode-js-debug\\out\\src\\dapDebugServer.js')},
		  }
		  dap.adapters["chrome"] = {
				type = "executable",
				command = "node",
				args = {vim.fn.resolve(vim.fn.stdpath("data")..'\\lazy\\vscode-js-debug\\out\\src\\dapDebugServer.js')},
		  }
            
            for _, language in ipairs(local_js_based_languages) do 
                dap.configurations[language] = {
				{
				  type = "pwa-chrome",
				  request = "launch",
				  name = "Start Chrome with \"localhost\"",
				  url = "http://localhost:3006",
				  webRoot = "${workspaceFolder}",
				},
				{name="--Proect Options --"},
				{
					type = "chrome",
					request = "launch",
					url = "http://localhost:3006",
					name = "Start Chrome with diffrent"
				}
                }
            end
        end,
        keys = {
            {
                "<leader>dt",
                function()
                    require("dap").step_out()
                end,
                desc = "Step Out",
            },
            {
                "<leader>di",
                function()
                    require("dap").step_into()
                end,
                desc = "Step Into",
            },
            {
                "<leader>do",
                function()
                    require("dap").step_over()
                end,
                desc = "Step Over",
            },
            {
                "<leader>da",
                function()
                    require("dap").continue()
                end,
                desc = "Run Debugger",
            },
            {
                "<leader>db",
                function()
                    require("dap").toggle_breakpoint()
                end,
                desc = "Toggle Breakpoint",
            },
        },
    },
}
