-- Disable automatic previews.
-- # Hello!
vim.keymap.set("n", "<leader>m", function() 
	pcall(
		vim.cmd, ":TSEnable highlight"
	)
	pcall(
		vim.cmd, ":RenderMarkdown buf_toggle"
	)
end, { desc = "Toggles `markview` previews globally." });

require('render-markdown').setup({
    completions = { lsp = { enabled = true } },
    on = {
    	attach = function (ctx) 
	pcall(
		vim.cmd, ":TSEnable highlight"
	)
	end
    }
})
