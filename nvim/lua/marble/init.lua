require("marble.autocomplete")
require("marble.remap")

vim.cmd("set rnu")
vim.api.nvim_set_option("clipboard", "unnamedplus")
-- allow netrw to copy files to same directory 
vim.cmd [[
	let g:netrw_keepdir=1
]]
