return {
	"mfussenegger/nvim-dap",
	config = function()
		local map = function(mode, keys, func, desc, opts)
			opts = opts or {}
			opts.desc = desc
			vim.keymap.set(mode, keys, func, opts)
		end
		local dap = require("dap")
		vim.keymap.set("n", "<Leader>dc", dap.continue(), { desc = " Continue" })
		map("n", "<F10>", dap.step_over(), " Step over")
		map("n", "<F11>", dap.step_into(), " Setp Into")
		map("n", "<F12>", dap.step_out(), " Step out")
		map("n", "<F12>", toggle_breakpoint(), " Step out")

		map("n", "<leader>dt", dap.set_breakpoint(), " Set Breakpoint")
		map("n", "<leader>dl", dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")), " Log Point")
	end,
}
