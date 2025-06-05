-- LSPs
vim.lsp.enable("pyright")
vim.lsp.enable('emmet_ls')
vim.lsp.enable('ts_ls')

-- vim.lsp.enable("jedi_language_server")

-- Keybinds
vim.diagnostic.config({ jump = { float = true } })

vim.keymap.set("n", "]e", function()
	vim.diagnostic.jump({
		count = 1,
		severity = vim.diagnostic.severity.ERROR,
		wrap = true,
	})
end)

vim.keymap.set("n", "[e", function()
	vim.diagnostic.jump({
		count = -1,
		severity = vim.diagnostic.severity.ERROR,
		wrap = true,
	})
end)

vim.keymap.set("n", "[g", function()
	vim.diagnostic.jump({
		count = -1,
		wrap = true,
	})
end)

vim.keymap.set("n", "]g", function()
	vim.diagnostic.jump({
		count = 1,
		wrap = true,
	})
end)

-- Show giagnostic messages
vim.keymap.set("n", "<leader>l", vim.diagnostic.setloclist)


vim.keymap.set('n','gd', vim.lsp.buf.definition)
