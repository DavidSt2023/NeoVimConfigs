local local_js_based_languages = {
	"typescript",
	"javascript",
	"typescriptreact",
	"javascriptreact",
	"vue",
}

local dap_icons = {
	Breakpoint = { "", "DiagnosticError" },
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
			{
				"microsoft/vscode-js-debug",
				build = "npm install --legacy-peer-deps && npx gulp dapDebugServer && mv dist out",
			},
			{ "microsoft/vscode-chrome-debug" },
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()
			require("dap").set_log_level("DEBUG")
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapStopped",
				{ text = "▶️", texthl = "DiagnosticInfo", linehl = "Visual", numhl = "" }
			)
			vim.fn.sign_define("DapLogPoint", { text = "📜", texthl = "DiagnosticWarn", linehl = "", numhl = "" })

			dap.set_log_level("DEBUG")
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
				type = "executable",
				command = "node",
				args = {
					vim.fn.resolve(vim.fn.stdpath("data") .. "\\lazy\\vscode-js-debug\\out\\src\\dapDebugServer.js"),
				},
			}
			dap.adapters["chrome"] = {
				type = "executable",
				command = "node",
				args = {
					vim.fn.resolve(vim.fn.stdpath("data") .. "\\lazy\\vscode-chrome-debug\\out\\src\\chromeDebug.js"),
				},
			}
			require("dap.ext.vscode").load_launchjs(nil, {
				["chrome"] = local_js_based_languages,  -- Ordne den Chrome-Adapter den JS-basierten Sprachen zu
				["pwa-chrome"] = local_js_based_languages,
			})

			for _, language in ipairs(local_js_based_languages) do
				dap.configurations[language] = {
					{
						type = "chrome",
						request = "launch",
						name = "Launch Chrome with Debugging",
						url = function()
							local input = vim.fn.input("Enter Debug Port: ", "3000")
							return input ~= "" and "http://localhost:" .. input or "http://localhost:3006"
						end,
 						webRoot = "${workspaceFolder}",
						userDataDir = true, -- Nutzt die normale Chrome-Instanz
						port = 9222,
					},
					{ name = "--Project Options --" },
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
			{
				"<Leader>dB",
				function()
					require("dap").set_breakpoint()
				end,
				desc = "set Breakpoint",
			},
		},

	},
}
