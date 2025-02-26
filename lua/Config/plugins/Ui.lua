return {
	{ "stevearc/dressing.nvim" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		options = { theme = "slanted-gaps" },
		config = function()
			require("lualine").setup({})
		end,
	},
	{
		"nxtkofi/LightningNvim",
		config = function()
			-- Hier kannst du eine beliebige Konfiguration für LightningNvim hinzufügen
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					separator_style = "slope",
					diagnostics_indicator = function(count, level, diagnostics_dict, context)
						local s = " "
						for e, n in pairs(diagnostics_dict) do
							local sym = e == "error" and " " or (e == "warning" and " " or " ")
							s = s .. n .. sym
						end
						return s
					end,
				},
			})
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup()
			vim.notify = require("notify")
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup({
			})
		end,
	},
}
