--- ~/nvim/lua/slydragonn/plugins/treesiter.lua

return {
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "m-demare/hlargs.nvim",
  },
  opts = {
    highlight = {
      enable = true
    },
    indent = {
      enable = true
    },
    auto_install = true,
    ensure_install = {
      "lua",
      "java",
      "javascript",
    },
  },
  config = function(_, opts)
    require('hlargs').setup()
    local configs = require("nvim-treesitter.configs")
    configs.setup(opts)
  end
}
