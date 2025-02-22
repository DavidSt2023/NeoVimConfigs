return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup({
        size = 10,
        shading_factor = 2,
        direction = "tab",
		shell = "powershell",
		windbar = {
		enabled = true,
		},
    }) 

  end,
}
