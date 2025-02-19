return
{
    -- https://github.com/echasnovski/mini.nvim?tab=readme-ov-file#plugin-colorschemes
  "echasnovski/mini.nvim",
  version = false, -- Hol dir immer die neueste Version
  config = function()
    require("mini.surround").setup({
      mappings = {
        add = "<C-s>",     -- Statt 'sa'
        delete = "<C-d>",  -- Statt 'sd'
        replace = "<C-r>", -- Statt 'sr'
      }
    })
    require("mini.pairs").setup({
      modes = { insert = true, command = false },
    })
    require("mini.comment").setup()
  end,
}
