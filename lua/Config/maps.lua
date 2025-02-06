-- ~/nvim/lua/slydragonn/maps.lua

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = function(mode, keys, func, desc, opts)
	opts = opts or {}
	opts.desc = desc
	vim.keymap.set(mode, keys, func, opts)
end

-- Save
map("n", "<leader>w", "<CMD>update<CR>", "Save")

-- Quit
map("n", "<leader>qq", "<CMD>q<CR>", "Quit")
map("n", "<leader>qr", "<Cmd>w<Bar>Alpha<Bar>redraw!<CR>", "Dashboard with Saving")
map("n", "<leader>qw", "<CMD>wq<CR>", "Quit with Saving")
-- Exit insert mode
map("i", "jk", "<ESC>", "Exit Insert Mode")

-- NeoTree
map("n", "<leader>e", "<CMD>Neotree toggle<CR>")
map("n", "<leader>r", "<CMD>Neotree focus<CR>")
 
-- New Windows
map("n", "<leader>o", "<CMD>vsplit<CR>", "Vertical Split")
map("n", "<leader>p", "<CMD>split<CR>", "Horizontal Split")

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
map("n", "<leader>od", "<CMD>Copilot disable <CR>", "Deaktivate Copilot")
map("n", "<leader>oa", "<CMD>Copilot <CR>", "Aktivate Copilot")
map("n", "<leader>oc", "<CMD>CopilotChat <CR>", "Copilot Chat")

--Transparency
map("n", "<leader>tc", ":TransparentToggle<CR>", "Toggle transparency", { noremap = true, silent = true })

--Reminders
map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>', "Hint: Use h")
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>', "Hint: Use l")
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>', "Hint: Use k")
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>', "Hint: Use j")

--Settings
map("n", "<leader>st", "<CMD>ThemePicker<CR>", "Theme auswählen")


map("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>",  "Next Buffer" )
--Telescope
		map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", "Fuzzy find files in cwd")
		map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",  "Fuzzy find recent files" )
		map("n", "<leader>fb", "<cmd>Telescope buffers<cr>",  "Find string in cwd" )
		map("n", "<leader>fs", "<cmd>Telescope git_status<cr>",  "Find string under cursor in cwd" )
		map("n", "<leader>fc", "<cmd>Telescope git commits<cr>", "Find todos" )
