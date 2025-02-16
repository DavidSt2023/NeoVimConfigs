return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local cmp = require("cmp")
		-- `/` cmdline setup.
		cmp.setup.cmdline("/", {
		  mapping = cmp.mapping.preset.cmdline(),
		  sources = {
			{ name = "buffer" },
		  },
		})

		-- `:` cmdline setup.
		cmp.setup.cmdline(":", {
		  mapping = cmp.mapping.preset.cmdline(),
		  sources = cmp.config.sources({
			{ name = "path" },
		  }, {
			{
			  name = "cmdline",
			  option = {
				ignore_cmds = { "Man", "!" },
			  },
			},
		  }),
		})
		local nvim_lsp = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local protocol = require("vim.lsp.protocol")
		local on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
		end


		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		mason_lspconfig.setup_handlers({
			function(server)
				nvim_lsp[server].setup({
					capabilities = capabilities,
				})
			end,
			["cssls"] = function()
				nvim_lsp["cssls"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["tailwindcss"] = function()
				nvim_lsp["tailwindcss"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["html"] = function()
				nvim_lsp["html"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["jsonls"] = function()
				nvim_lsp["jsonls"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["eslint"] = function()
				nvim_lsp["eslint"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,

			["ast_grep"] = function()
				nvim_lsp["ast_grep"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						ast_grep = {
							enable = true,
							patterns = {},
						},
					},
				})
			end,
		})
	end,
}
