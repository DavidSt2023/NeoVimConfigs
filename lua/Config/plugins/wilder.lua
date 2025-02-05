return {
  "gelguy/wilder.nvim",
  event = "VeryLazy",  -- Lazy loading, wenn ein Befehl oder eine Funktion verwendet wird
  config = function()
    -- Wilder.nvim Konfiguration
    local wilder = require("wilder")

    -- Wilder Optionen setzen
    wilder.setup({
      modes = { ":", "/", "?" },  -- Gebrauchte Modi (Kommandozeile, Suche, etc.)
    })

    -- Quelle für Wilder konfigurieren
    wilder.set_option(
      "renderer",
      wilder.popupmenu_renderer({
        -- Stileinstellungen für das Popup-Menü
        highlighter = wilder.basic_highlighter(),
        left = { " ", wilder.popupmenu_devicons() },  -- Icons auf der linken Seite
        right = { " " },  -- Rechte Seite bleibt leer
      })
    )

    -- Quellen für die Vorschläge setzen
    wilder.set_option("pipeline", {
      wilder.branch(
        wilder.cmdline_pipeline({
          fuzzy = 2,  -- Fuzzy-Suche auf Befehlseingabe anwenden
        }),
        wilder.python_file_finder_pipeline({
          file_command = "fd",
          dir_command = "fd --type d",
        })
      ),
    })
  end,
}
