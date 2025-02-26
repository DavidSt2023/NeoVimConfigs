return {
  "folke/edgy.nvim",
  --echo bufname('%')
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
    right = {
      {
        ft = "neo-tree",
        title = "File Explorer",
        size = { width = 0.2 },
      },
    },
    bottom = {
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
    },
    animate = {
      enable = true,
      fps = 120,
      spinner = {
        frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
        interval = 80,
      },
    },
    wo = {
      winbar = true,
      winfixwidth = true,
      winfixheight = false,
      winhighlight = "WinBar:EdgyWinBar,Normal:EdgyNormal",
      spell = false,
      signcolumn = "no",
    },
  },
}
