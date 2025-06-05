require("dapui").setup({
	controls = {
		element = "repl",
		enabled = true,
		icons = {
			disconnect = "",
			pause = "",
			play = "",
			run_last = "",
			step_back = "",
			step_into = "",
			step_out = "",
			step_over = "",
			terminate = "",
		},
	},
	element_mappings = {},
	expand_lines = true,
	floating = {
		border = "single",
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	force_buffers = true,
	icons = {
		collapsed = "",
		current_frame = "",
		expanded = "",
	},
	layouts = {
		{
			elements = {
				{
					id = "scopes",
					size = 0.33,
				},
				{
					id = "breakpoints",
					size = 0.33,
				},
				{
					id = "stacks",
					size = 0.33,
				},
			},
			position = "left",
			size = 10,
		},
		{
			elements = {
				{
					id = "repl",
					size = 0.85,
				},
			},
			position = "bottom",
			size = 10,
		},
	},
	mappings = {
		edit = "e",
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		repl = "r",
		toggle = "t",
	},
	render = {
		indent = 1,
		max_value_lines = 100,
	},
})
require("dap-python").setup("python3")

vim.keymap.set("n", "<leader>dt", require("dapui").toggle)
vim.keymap.set("n", "<leader>da", require("dap").toggle_breakpoint)

vim.keymap.set("n", "<leader>ds", require("dap").step_over)
vim.keymap.set("n", "<leader>di", require("dap").step_into)

vim.keymap.set("n", "<leader>dc", require("dap").continue)

local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end
