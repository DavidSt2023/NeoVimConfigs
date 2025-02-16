return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	dependencies = { "nvim-lua/plenary.nvim","nvim-telescope/telescope-live-grep-args.nvim" },
	config = function()
	local telescope = require("telescope")
		telescope.setup({
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
				},
			},
			  pickers = {
				find_files = {
				  theme = "dropdown",
				}
			  },
		})
		 telescope.load_extension("live_grep_args")
	end,
}
