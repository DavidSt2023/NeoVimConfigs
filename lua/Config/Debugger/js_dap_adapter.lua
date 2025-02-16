-- lua/Config/Debugger/dap_adapters.lua

local dap = require("dap")

local local_js_based_languages = {
    "typescript",
    "javascript",
    "typescriptreact",
    "javascriptreact",
    "vue",
}

dap.set_log_level("DEBUG")


vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
	os.execute("npx kill-port 9222")
	vim.wait(2000)
	end
})



-- Adapter für pwa-node und pwa-chrome
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

-- Konfiguration für die unterstützten Sprachen
for _, language in ipairs(local_js_based_languages) do
    dap.configurations[language] = {
        {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch Chrome with Debugging",
            url = "http://localhost:5173",
            webRoot = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
    }
end

return {}  -- Stellt sicher, dass das Modul eine Tabelle zurückgibt
