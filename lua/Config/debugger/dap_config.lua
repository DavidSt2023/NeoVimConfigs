return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui" },
    { "nvim-neotest/nvim-nio" },
    { "theHamsta/nvim-dap-virtual-text" },
    {"mfussenegger/nvim-jdtls" ,dependencies={'mfussenegger/nvim-dap'}},
    {"eclipse-jdtls/eclipse.jdt.ls" ,build= './mvnw clean verify  -DskipTests=true'},
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
      },
      sidebar = {
        open_on_start = true,
        elements = {
          -- You can change the order of elements in the sidebar
          "scopes",
          "breakpoints",
          "stacks",
          "watches",
        },
        width = 40,
        position = "left", -- Can be "left" or "right"
      },
      tray = {
        open_on_start = true,
        elements = { "repl" },
        height = 10,
        position = "bottom", -- Can be "bottom" or "top"
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
      },
      windows = { indent = 1 },
    })

    require("nvim-dap-virtual-text").setup({
      virtual_text = true,
      underline = true,
      signs = true,
      update_on_change = true,
      all_frames = true,       -- Sehr gut, da dies alle Stack Frames abdeckt
    })


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
