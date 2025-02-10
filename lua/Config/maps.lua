-- v/nvim/lua/slydragonn/maps.lua

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = function(mode, keys, func, desc, opts)
	opts = opts or {}
	opts.desc = desc
	vim.keymap.set(mode, keys, func, opts)
end

-- Save
map({ "n", "v" }, "<leader>w", "<cmd>w<cr>", "⚡ Write")
map("n", "<C-s>", "<CMD>update<CR>", "Save")

-- Quit
map("n", "<leader>Q", "<CMD>quitall!<CR>", "Quit")
map("n", "<leader>qr", "<Cmd>w<Bar>Alpha<Bar>redraw!<CR>", "Dashboard with Saving")
map("n", "<leader>qq", "<Cmd>q!<CR>", "Quit without Saving")
map("n", "<leader>qw", "<CMD>wq<CR>", "Quit with Saving")
-- Exit insert mode
map("i", "jk", "<ESC>", "Exit Insert Mode")

-- NeoTree
map("n", "<leader>ne", "<CMD>Neotree toggle<CR>", "NT Toggle")
map("n", "<leader>nr", "<CMD>Neotree focus<CR>", "NT Focus")
map("n", "<leader>nR", "<CMD>Neotree source=filesystem<CR>", "NT Filesystem")

-- New Windows
map("n", "<leader>sv", "<CMD>vsplit<CR>", "Vertical Split")
map("n", "<leader>sh", "<CMD>split<CR>", "Horizontal Split")

-- Window Navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-j>", "<C-w>j")

-- Resize Windows
map("n", "<C-Left>", "<C-w><")
map("n", "<C-Right>", "<C-w>>")
map("n", "<C-Up>", "<C-w>+")
map("n", "<C-Down>", "<C-w>-")

--Copilot
map("n", "<leader>/d", "<CMD>Copilot disable <CR>", "Deaktivate Copilot")
map("n", "<leader>/a", "<CMD>Copilot <CR>", "Aktivate Copilot")
map("n", "<leader>/c", "<CMD>CopilotChat <CR>", "Copilot Chat")

--Reminders
map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>', "Hint: Use h")
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>', "Hint: Use l")
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>', "Hint: Use k")
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>', "Hint: Use j")

--Settings
map("n", "<leader>/t", "<CMD>ThemePicker<CR>", "Theme auswählen")
map("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>", "Next Buffer")

--Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", "Find File")
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", "Buffers")
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", "Recent  files")

--File Mangament
map("n", "<leader>fn", "<cmd>enew<cr>", "New File")
map("n", "<leader>fd", "<cmd>bd<cr>", "Delete File")
map("n", "<leader>fs", "<cmd>write<cr>", "Save File")
map("n", "<leader>fR", "<cmd>edit %<cr>", "Reload File")
