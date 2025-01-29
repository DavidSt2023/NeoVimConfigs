-- ~/.config/nvim/lua/Config/plugins/dashboard.lua
return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Falls Icons benötigt werden
  config = function()
  
local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

-- Lade das ASCII-Bild aus girl_cig.lua
local girl_cig = require('Config.plugins.Images.girl_cig')  -- Pfad zur Lua-Datei

-- Setze das Bild als Header
dashboard.section.header = girl_cig

-- Setze die Buttons für den Startbildschirm
dashboard.section.buttons.val = {
    dashboard.button('f', '  Find file', ':Telescope find_files<CR>'),
    dashboard.button('r', '  Recent files', ':Telescope oldfiles<CR>'),
    dashboard.button('n', '  New file', ':enew<CR>'),
    dashboard.button('q', '  Quit Neovim', ':qa<CR>'),
}

    -- Footer
    dashboard.section.footer.val = "Welcome to Neovim"

    alpha.setup(dashboard.config)
  end,
}