return {
	-- tokyonight.nvim
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				style = "storm", -- Stil: "night", "storm", "day"
				transparent = true, -- Transparente Hintergründe (optional)
				terminal_colors = true, -- Farbschema für Terminal (optional)
				dim_inactive = true, -- Inaktive Fenster dimmen
				lualine_bold = true, -- Lualine Text fett (optional)
			})
			-- Farbschema aktivieren
			vim.cmd("colorscheme tokyonight")
		end,
	},
}
