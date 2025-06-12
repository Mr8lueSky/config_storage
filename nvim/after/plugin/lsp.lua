-- LSPs
vim.lsp.enable("basedpyright")
vim.lsp.enable("ts_ls")
vim.lsp.enable("rust_analyzer")

local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").cssls.setup({
	capabilities = capabilities,
})

lspconfig.emmet_ls.setup({
	-- on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
		"css",
		"eruby",
		"html",
		"javascript",
		"javascriptreact",
		"less",
		"sass",
		"scss",
		"svelte",
		"pug",
		"typescriptreact",
		"vue",
	},
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = true,
			},
		},
	},
})

vim.lsp.enable("emmet_ls")

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

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
