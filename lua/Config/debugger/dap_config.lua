return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui" },
    { "nvim-neotest/nvim-nio" },
    { "theHamsta/nvim-dap-virtual-text" },
    { "mfussenegger/nvim-jdtls" }, -- Add jdtls as explicit dependency
  },

  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dap.set_log_level("TRACE")

    dapui.setup({})

    require("nvim-dap-virtual-text").setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
      clear_on_continue = true,
      display_callback = function(variable, buf, stackframe, node, options)
        if options.virt_text_pos == 'inline' then
          return ' = ' .. variable.value:gsub("%s+", " ")
        else
          return variable.name .. ' = ' .. variable.value:gsub("%s+", " ")
        end
      end,
      virt_text_pos = 'eol',
      all_frames = false,
      virt_lines = false,
      virt_text_win_col = nil
    })

    -- Dap UI Auto-Open / Close
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- Configure debug adapters
    require("Config.debugger.adapters.js_dap_adapter").configure_js_adapter()

    -- Dap Breakpoint und Stopped-Symbole
    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = 'ﳁ', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    vim.fn.sign_define('DapLogPoint', { text = '󰐃', texthl = 'DapLogPoint', linehl = 'DapLogPoint', numhl = 'DapLogPoint' })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapBreakpointStoped', linehl = 'DapStopped', numhl = 'DapStopped' })
  end
}
