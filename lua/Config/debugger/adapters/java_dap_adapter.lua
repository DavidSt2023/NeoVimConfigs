local M = {}


vim.api.nvim_set_keymap("n", "<leader>dj", "<cmd>lua pick_java_class()<CR>", { noremap = true, silent = true })
local dap =  require("dap")
M.setupJava = function()
  -- Pfad zum Debug Adapter abrufen
  local java_debug_path = vim.fn.stdpath("data") .. "\\java-debug-adapter\\extension\\server"
  dap.adapters.java = {
    type = "server",
    host = "127.0.0.1",
    port = 5005, -- Standard Debugging-Port
  }

  dap.configurations.java = {
    {
      type = "java",
      request = "attach",
      name = "Java Debug (Attach)",
      hostName = "127.0.0.1",
      port = 5005,
    },
    {
      type = "java",
      request = "launch",
      name = "Java Launch",
      mainClass = "Main",          -- Passe dies an dein Projekt an
      projectName = "MeinProjekt", -- Optional
      cwd = vim.fn.getcwd(),
    },
  }
end
return M
