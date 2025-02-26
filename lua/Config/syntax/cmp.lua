return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"hrsh7th/cmp-cmdline", -- Füge cmp-cmdline hinzu
		"hrsh7th/cmp-buffer",
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		{
			"mfussenegger/nvim-jdtls",
			dependencies = "hrsh7th/cmp-nvim-lsp",
		},
	},
	config = function()
		local cmp = require("cmp")
		local  luasnip = pcall(require, "luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			preselect = cmp.PreselectMode.None,
			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-o>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					-- Tab accepts the completion if CMP menu is visible and one item is selected
					-- If not it will send the action for Snippets or others (Copilot)
					if cmp.visible() and cmp.get_selected_entry() then
						cmp.confirm({ select = true })
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "lazydev" },
				{ name = "buffer" },
			}, {
				{ name = "buffer" },
			}),
		})

		-- Setup cmdline for ':'
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "cmdline" },
			},
		})

		-- Setup cmdline for '/'
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})
	end,
}
