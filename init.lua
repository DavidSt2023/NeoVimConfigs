require("Config.settings")
require("Config.lazy")
require("Config.maps")

local tools_dir = vim.fn.stdpath("config") .. "/lua/Config/tools/"
local files = vim.fn.globpath(tools_dir, "*.lua", false, true)

for _, file in ipairs(files) do
	local module_name = "Config.tools." .. vim.fn.fnamemodify(file, ":t:r") -- Entfernt den Pfad und .lua-Endung
	require(module_name)
end
--set Theme
local settings = require("Config.userSettings")
local Theme = settings.getSettings()["Theme"]
vim.cmd("colorscheme " .. Theme)
--edgy settings
vim.opt.splitkeep = "screen"
vim.opt.laststatus = 3

vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#993939' })
vim.api.nvim_set_hl(0, 'DapBreakpointStoped', { fg = '#ffbe10' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#61afef', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapStopped', {  bg = '#504c1c'})