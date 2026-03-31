-- LSPs
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- vim.lsp.enable("ts_ls")
vim.lsp.config("ts_ls",
               {workspace_required = true, root_markers = {"package.json"}})
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("basedpyright")
vim.lsp.config('basedpyright', {
    root_markers = {
        "pyproject.toml", "setup.py", "setup.cfg", "pyrightconfig.json", ".git"
    }
})

capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Keybinds
vim.diagnostic.config({jump = {float = true}})

vim.keymap.set("n", "]e", function()
    vim.diagnostic.jump({
        count = 1,
        severity = vim.diagnostic.severity.ERROR,
        wrap = true
    })
end)

vim.keymap.set("n", "[e", function()
    vim.diagnostic.jump({
        count = -1,
        severity = vim.diagnostic.severity.ERROR,
        wrap = true
    })
end)

vim.keymap.set("n", "[g",
               function() vim.diagnostic.jump({count = -1, wrap = true}) end)

vim.keymap.set("n", "]g",
               function() vim.diagnostic.jump({count = 1, wrap = true}) end)

-- Show giagnostic messages
vim.keymap.set("n", "<leader>l", vim.diagnostic.setloclist)

-- Next/Previous quick fix
vim.keymap.set("n", "<C-S-L>", function () 
	pcall(
		vim.cmd,
		"cnext"
	)
	pcall(
		vim.cmd,
		"lne"
	)
end)
vim.keymap.set("n", "<leader>pp", function () 
	pcall(
		vim.cmd,
		"cprevious"
	)
	pcall(
		vim.cmd,
		"lp"
	)
end)

vim.keymap.set("n", "gd", vim.lsp.buf.definition)

