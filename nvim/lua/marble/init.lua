require("marble.autocomplete")
require("marble.remap")

vim.cmd("set rnu")
vim.cmd("set number")
vim.api.nvim_set_option("clipboard", "unnamedplus")
-- allow netrw to copy files to same directory 
vim.o.exrc = true
vim.cmd [[
	let g:netrw_keepdir=1

]]
