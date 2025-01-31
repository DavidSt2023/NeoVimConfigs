return {
	"github/copilot.vim",
	config = function()
		-- Zusätzliche Konfigurationen für Copilot, wenn gewünscht
		-- Beispiel: Deaktiviere Tab-Taste für automatische Vorschläge
		vim.g.copilot_no_tab_map = true

		-- Weitere benutzerdefinierte Einstellungen:
		-- vim.g.copilot_filetypes = { "javascript", "python", "lua" } -- Aktiviert Copilot nur für bestimmte Dateitypen
	end,
}
