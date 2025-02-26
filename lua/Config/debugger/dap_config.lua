return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui" },
    { "nvim-neotest/nvim-nio" },
    { "theHamsta/nvim-dap-virtual-text" },
    { "mfussenegger/nvim-jdtls",        dependencies = { 'mfussenegger/nvim-dap' } },
    { "eclipse-jdtls/eclipse.jdt.ls",   build = './mvnw clean verify  -DskipTests=true' },
  },

  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dap.set_log_level("TRACE")

    dapui.setup({
      expand_lines = true,
      render = {
        max_type_length = nil, -- Setzt kein Limit für den Typ
        max_value_lines = 10,  -- Anzahl der Zeilen für lange Werte
      },
    })

    require("nvim-dap-virtual-text").setup {
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
      clear_on_continue = false,
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
    }

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

    require("Config.debugger.adapters.js_dap_adapter").configure_js_adapter()

    -- Farbliche Markierung für REPL-Ausgaben
    dap.repl.commands = {
      eval = function(str)
        -- Fehler und Warnungen im REPL farblich hervorheben
        if str:match("ERROR") then
          -- Fehlernachricht in rot
          vim.api.nvim_out_write(str .. "\n")
          vim.cmd("highlight DapError guifg=#ff0000 gui=bold")
          vim.api.nvim_buf_add_highlight(0, -1, "DapError", 0, 0, -1)
        elseif str:match("WARNING") then
          -- Warnmeldung in orange
          vim.api.nvim_out_write(str .. "\n")
          vim.cmd("highlight DapWarning guifg=#ffa500 gui=bold")
          vim.api.nvim_buf_add_highlight(0, -1, "DapWarning", 0, 0, -1)
        else
          vim.api.nvim_out_write(str .. "\n")
        end
      end
    }

    -- Dap Breakpoint und Stopped-Symbole
    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = 'ﳁ', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    vim.fn.sign_define('DapLogPoint',
      { text = '󰐃', texthl = 'DapLogPoint', linehl = 'DapLogPoint', numhl = 'DapLogPoint' })
    vim.fn.sign_define('DapStopped',
      { text = '', texthl = 'DapBreakpointStoped', linehl = 'DapStopped', numhl = 'DapStopped' })

    -- Definieren von Highlight-Gruppen für Fehler und Warnungen
    vim.cmd("highlight DapError guifg=#ff0000 gui=bold")
    vim.cmd("highlight DapWarning guifg=#ffa500 gui=bold")
  end

}
