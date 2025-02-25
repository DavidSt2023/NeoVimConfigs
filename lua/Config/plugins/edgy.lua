return {
  "folke/edgy.nvim",
  opts = {
    left = { -- Fenster, die rechts angezeigt werden sollen
      {
        ft = "dapui_watches",
        title = "Watches",
        size = { height = 0.5 }
      },
      {
        ft = "dapui_breakpoints",
        title = "Breakpoints",
        size = { height = 0.2 }
      },
      {
        ft = "dapui_stacks",
        title = "Stacks",
        size = { height = 0.1 }
      },
      {
        ft = "dapui_console",
        title = "Console",
        size = { height = 0.1 }
      },
    },
    bottom = { -- Fenster, die unten angezeigt werden sollen

      {
        ft = "dap-repl",
        title = "REPL",
        size = { height = 0.1 }
      },

      {
        ft = "dapui_scopes",
        title = "Scopes",
        size = { height = 0.2 }
      },
    }
  },
}
