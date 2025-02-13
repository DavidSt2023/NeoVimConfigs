local local_js_based_languages = {
	"typescript",
	"javascript",
	"typescriptreact",
	"javascriptreact",
	"vue",
}

return {
	"microsoft/vscode-js-debug",
	build = "npm install --legacy-peer-deps && npx gulp dapDebugServer && mv dist out",
	dependencies = { "microsoft/vscode-chrome-debug", build = "npm install && npm run build" },
	config = function()
		local dap = require("dap")
		require("dap.ext.vscode").load_launchjs(nil, {
			["chrome"] = local_js_based_languages,
			["pwa-chrome"] = local_js_based_languages,
		})

		for _, language in ipairs(local_js_based_languages) do
			dap.configurations[language] = {
				{ name = "--Configured Options --" },
				{
					type = "chrome",
					request = "launch",
					name = "Launch Chrome with Debugging",
					url = function()
						local input = vim.fn.input("Enter Debug Port: ", "3000")
						return input ~= "" and "http://localhost:" .. input or "http://localhost:3006"
					end,
					webRoot = "${workspaceFolder}",
					userDataDir = true,
					port = 9222,
				},
				{ name = "--Project Options --" },
			}
		end

		dap.adapters["pwa-chrome"] = {
			type = "executable",
			command = "node",
			args = {
				vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/out/src/dapDebugServer.js"),
			},
		}

		dap.adapters["chrome"] = {
			type = "executable",
			command = "node",
			args = {
				vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-chrome-debug/out/src/chromeDebug.js"),
			},
		}
	end,
}
