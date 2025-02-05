return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({
			defaults = {
				selection_caret = "󱞩 ",
				initial_mode = "normal",
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--glob",
					"!**/.git/*", -- Excludes everything inside .git
				},
			},
			  pickers = {
				find_files = {
				  theme = "dropdown",
				}
			  },
		})
	end,
}
