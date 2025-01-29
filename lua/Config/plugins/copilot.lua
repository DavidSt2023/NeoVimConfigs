return {
	"github/copilot.vim",
	config = function()
		-- Zusätzliche Konfigurationen für Copilot, wenn gewünscht
		-- Beispiel: Deaktiviere Tab-Taste für automatische Vorschläge
		vim.g.copilot_no_tab_map = true

		vim.api.nvim_set_keymap(
			"n",
			"<Leader>ce",
			[[:lua require("Config.plugins.copilot").enable_copilot()<CR>]],
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<Leader>cd",
			[[:lua require("Config.plugins.copilot").disable_copilot()<CR>]],
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<Leader>cs",
			[[:lua require("Config.plugins.copilot").show_suggestions()<CR>]],
			{ noremap = true, silent = true }
		)
		-- Weitere benutzerdefinierte Einstellungen:
		-- vim.g.copilot_filetypes = { "javascript", "python", "lua" } -- Aktiviert Copilot nur für bestimmte Dateitypen
	end,
}
