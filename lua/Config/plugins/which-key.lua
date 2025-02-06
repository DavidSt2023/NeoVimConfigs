return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		icons = {
			breadcrumb = "»",
			separator = "➜",
			group = "-",
		},
	},
	config = function()
		local wk = require("which-key")
		wk.add({
			{ "<leader>t", group = "Themes" },
			{ "<leader>q", group = " Home" },
			{ "<leader>n", group = "Neotree", icon = "󰙅" },
			{ "<leader>f", group = "File", icon = "󰈞" },
			{ "<leader>d", group = "Debugger", icon = "🐞" },
			{ "<leader>s", group = "Windows" },
			{ "<leader>/", group = "Ui", icon = "🎨" },
			{
				"<leader>b",
				group = "Buffers",
				expand = function()
					return require("which-key.extras").expand.buf()
				end,
			},
		})
	end,
}
