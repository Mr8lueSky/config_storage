require("marble.autocomplete")
require("marble.remap")
require("marble.fixes")

vim.cmd("set rnu")
vim.cmd("set number")
vim.cmd("setlocal spell spelllang=en_us,ru")
vim.api.nvim_set_option("clipboard", "unnamedplus")
-- allow netrw to copy files to same directory 
vim.o.exrc = true
vim.cmd [[
	let g:netrw_keepdir=1
	let g:netrw_bufsettings="rnu"
]]
