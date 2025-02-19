return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"mason-org/mason-registry",
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
				"lua_ls",
				"ts_ls",
				"jdtls",
				"ltex",
				"tailwindcss",
				"jdtls",
			},
		})
  require("mason-tool-installer").setup({
    ensure_installed = {
      "prettier",
      },
    })
	end,
}
