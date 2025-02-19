return {
  "hrsh7th/cmp-cmdline", -- Stelle sicher, dass `cmp` vorhanden ist
  config = function()
    local cmp = require("cmp")

    -- `/` Suchen-Completion (Suche im Buffer)

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" }, -- Pfadvervollständigung
      }, {
        { name = "cmdline", option = { ignore_cmds = { "Man", "!", "q", "w", "wq", "wa", "x", "qa", "noh" } } },
      }),
    })

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
  end,
}
