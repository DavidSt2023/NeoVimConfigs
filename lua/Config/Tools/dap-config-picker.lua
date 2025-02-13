local dap = require("dap")
local telescope = require("telescope")
local actions = require("telescope.actions")
local M = {}

-- Die Auswahl der Debug-Konfiguration in Telescope und das Fortsetzen des Debuggers
M.continue_with_config = function()
  -- Hole die Liste der verfügbaren DAP-Konfigurationen
  local configs = vim.tbl_keys(dap.configurations)

  -- Überprüfen, ob Konfigurationen existieren
  if #configs == 0 then
    print("Keine DAP-Konfigurationen gefunden.")
    return
  end

  -- Starte Telescope, um eine Konfiguration auszuwählen
  telescope.pickers.new({
    prompt_title = "Select Debug Config",
    finder = telescope.finders.new_table({
      results = configs,
    }),
    sorter = telescope.config.values.generic_sorter({}),
    attach_mappings = function(_, map)
      -- Wenn eine Konfiguration ausgewählt wurde
      map("i", "<CR>", function(prompt_bufnr)
        local selection = actions.get_selected_entry(prompt_bufnr)
        if selection then
          -- Starte die Debug-Session mit der ausgewählten Konfiguration
          local config_name = selection.value
          dap.run(dap.configurations[config_name])
          dap.continue()  -- Dann das Fortsetzen starten
        end
        actions.close(prompt_bufnr)
      end)
      return true
    end,
  }):find()
end

-- Erstelle einen benutzerdefinierten Befehl in Vim mit Großbuchstaben
vim.api.nvim_create_user_command("DapPicker", function()
    M.continue_with_config()
end, {})

return M
