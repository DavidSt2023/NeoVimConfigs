return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui" },
    { "nvim-neotest/nvim-nio" },
    { "theHamsta/nvim-dap-virtual-text" },
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup()
    require("nvim-dap-virtual-text").setup({
      virtual_text = true,
      underline = true,
      signs = true,
      update_on_change = true,
      all_frames = true,
      virt_text_pos = "eol",
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
