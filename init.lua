require("Config.settings")
require("Config.lazy")
require("Config.maps") -- key bindings

local tools_dir = vim.fn.stdpath("config") .. "/lua/Config/Tools/"
local files = vim.fn.globpath(tools_dir, "*.lua", false, true)

for _, file in ipairs(files) do
	local module_name = "Config.Tools." .. vim.fn.fnamemodify(file, ":t:r") -- Entfernt den Pfad und .lua-Endung
	require(module_name)
end
--set Theme
local settings = require("Config.userSettings")
local Theme = settings.getSettings()["Theme"]
vim.cmd("colorscheme " .. Theme)
--edgy settings
vim.opt.splitkeep = "screen"
vim.opt.laststatus = 3

