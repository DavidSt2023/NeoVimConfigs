return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup({
        size = 10,
        open_mapping = [[<leader>c]],
        shading_factor = 2,
        direction = "tab",
		shell = "powershell",
		windbar = {
		enabled = true,
		},
    }) 

  end,
}