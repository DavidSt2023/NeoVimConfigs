local dap = require("dap")

local local_js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

local M = {}

function M.configure_js_adapter()
  dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = 9229,
    executable = {
      command = "node",
      args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "9229" },
    }
  }

  dap.adapters["pwa-chrome"] = {
    type = "server",
    host = "localhost",
    port = 9222,
    executable = {
      command = "node",
      args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "9222" },
    }
  }


  for _, language in ipairs(local_js_based_languages) do
    dap.configurations[language] = {
      {
        type = "pwa-chrome",
        request = "launch",
        name = "Launch Chrome with Debugging",
						url = function()
							local co = coroutine.running()
							return coroutine.create(function()
								vim.ui.input({
									prompt = "Enter Port: ",
									default = "3006",
								}, function(url)
									if url == nil or url == "" then
										return
									else
										coroutine.resume(co, "http://localhost:"..url)
									end
								end)
							end)
						end,
        webRoot = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch Portalserver with Node",
        runtimeExecutable = "npm",
        runtimeArgs = { "start" },
        cwd = "${workspaceFolder}",
        skipFiles = { "<node_internals>/**" },
      },
    }
  end
end

return M
