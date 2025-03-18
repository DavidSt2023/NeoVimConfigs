vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = function(mode, keys, func, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set(mode, keys, func, opts)
end


local telescope = require("telescope.builtin")


local dap, dapUi = require("dap"), require("dapui")



local function customInput(prompt, fn)
  local input = vim.ui.input({ prompt = prompt }, function(input) fn(input) end)
  return input ~= "" and input or nil
end

-- Save
map({ "n", "v" }, "<leader>w", "<cmd>w<cr>", "⚡ Write")
map("n", "<C-s>", "<CMD>update<CR>", "Save")

-- Quit
map("n", "<leader>Q", "<CMD>quitall!<CR>", "Quit")
map("n", "<leader>qr", "<Cmd>w<Bar>Alpha<Bar>redraw!<CR>", "Dashboard with Saving")
map("n", "<leader>qq", "<Cmd>bd<CR>", "Quit without Saving")
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
map("n", "<leader>/f", "<CMD>CopilotChatFix <CR>", "Copilot Chat")
map("n", "<leader>/o", "<CMD>CopilotChatOptimize <CR>", "Copilot Chat")
map('n', '<leader>/ca', 'copilot#Accept("<CR>")', "Accept Copilot")


--Settings
map("n", "<leader>/t", "<CMD>ThemePicker<CR>", "Theme auswählen")

--Telescope
map("n", "<leader>tf", "<cmd>Telescope find_files<cr>", "Find File")
map("n", "<leader>tb", "<cmd>Telescope buffers<cr>", "Buffers")
map("n", "<leader>tr", "<cmd>Telescope oldfiles<cr>", "Recent  files")
map("n", "<leader>tv", "<cmd>Telescope live_grep<cr>", "Search Variable")
map("n", "<leader>tV", function() telescope.live_grep({ additional_args = function() return { "-w" } end }) end,
  "Search Whole Variable")
map("n", "<leader>th", "<cmd>Telescope help_tags<cr>", "Help Tags")
map("n", "<leader>tk", "<cmd>Telescope keymaps<cr>", "Keymaps")
map("n", "<leader>tc", "<cmd>Telescope commands<cr>", "Commands")

--File Mangament
map("n", "<leader>fR", "<cmd>edit %<cr>", "Reload File")

map("n", "<leader>fw", vim.lsp.buf.format, "Format File")
--Dap

map("n", "<leader>dc", dap.continue, "Start Debugger")

map("n", "<F9>", dap.continue, "Continue")

map("n", "<leader>dl", function()
  dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, "Log Point")

map("n", "<leader>db", dap.toggle_breakpoint, "Toggle Breakpoint")

map("n", "<F10>", dap.step_over, "Step Over")

map("n", "<F11>", dap.step_into, "Step Into")

map("n", "<F12>", dap.step_out, "Step Out")

map("n", "<leader>dt", dapUi.toggle, "Toggle Ui")

map("n", "<leader>dw", function() customInput("Variable", dapUi.elements.watches.add) end, "Add Watch")

map("n", "<leader>dB", function() customInput("Breakpoint Condition:", dap.set_breakpoint) end, "Conditional Breakpoint")

map("n", "<leader>dm", dap.clear_breakpoints, "Clear Breakpoints")

map("n", "<leader>de", function() customInput("Variable:", dapUi.eval) end, "Evaluate Expression")

map("n", "<F4>", "<cmd>:lua get_dap_var_under_cursor()<CR>", "Get dap Variable under Cursor")
map("n", "<F3>","<cmd>:lua get_ts_var_under_cursor()<CR>", "Get Ts Variable under Cursor")


--Markdown
map("n", "<leader>mp", "<CMD>MarkdownPreview<CR>", "Markdown Preview")

--Navigation
map("n", "<leader>nt", function() vim.cmd("vsplit " .. vim.fn.stdpath("config") .. "/ToDo.md") end, "Open Todo")
map("n","U","<CMD>redo<CR>",'Redo')
map("n",    "<Tab>",         ">>",  "Indent Line")
map("n",    "<S-Tab>",       "<<",  "Unindent Line")
map("v",    "<Tab>",         ">gv", "Indent Selection")
map("v",    "<S-Tab>",       "<gv", "Unindent Selection")
map("i",    "<S-Tab>",       "<BS>", "Unindent Insert")

--Term
map("n","<F12>","<CMD>ToggleTerm<CR>")

--Git
map({"n","t"}, "<leader>gt", "<CMD>Gitsigns blame<CR>", "Git Blame Toggle")

