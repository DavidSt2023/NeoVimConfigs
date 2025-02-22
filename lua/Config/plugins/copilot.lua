return {
	"github/copilot.vim",
  dependencies = {"zbirenbaum/copilot.lua"} ,
	config = function()
		-- Zusätzliche Konfigurationen für Copilot, wenn gewünscht
		-- Beispiel: Deaktiviere Tab-Taste für automatische Vorschläge
		vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap("n", "<leader>/i", 'copilot#Accept("<CR>")', { silent = true, expr = true })

		-- Weitere benutzerdefinierte Einstellungen:
		-- vim.g.copilot_filetypes = { "javascript", "python", "lua" } -- Aktiviert Copilot nur für bestimmte Dateitypen
	end,
}
