require("marble.autocomplete")
require("marble.remap")
require("marble.fixes")
require("marble.helpers")

vim.cmd("set rnu")
vim.cmd("set number")
vim.cmd("setlocal spell spelllang=en_us,ru")
vim.o.clipboard = "unnamedplus"

-- allow netrw to copy files to same directory 
-- vim.o.exrc = true
vim.cmd [[
	" let g:netrw_keepdir=1
	let g:netrw_bufsettings="rnu"
]]
vim.opt.exrc = true
vim.o.winborder = "rounded"


vim.keymap.set('n', '<leader>ie', function()
  local config = vim.diagnostic.config() or {}
  local virt_text = config.virtual_text
  vim.diagnostic.config({ virtual_text = not virt_text })
end, { desc = "Toggle diagnostic virtual text" })

vim.keymap.set("n", "<leader>ih", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

vim.keymap.set("n", ":", "q:i", { desc = "Open command-line window" })
