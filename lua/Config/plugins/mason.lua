return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		require("mason").setup()
		
		require("mason-nvim-dap").setup({
			ensure_installed = { "js" },
			automatic_installation = true,
		})

		--only Listed https://github.com/williamboman/mason-lspconfig.nvim
		require("mason-lspconfig").setup({
			automatic_installation = true,
			ensure_installed = {
				"cssls",
				"eslint",
				"html",
				"jsonls",
				"ast_grep",
				"ltex",
				"tailwindcss",
			},
		})
	end,
}
