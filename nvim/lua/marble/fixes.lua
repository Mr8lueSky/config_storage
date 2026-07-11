-- allow netrw to copy files to same directory 
vim.cmd[[
	" let g:netrw_keepdir=0
	set noswapfile
]]
vim.opt.shell = "zsh -l"

vim.opt.hidden = true
vim.opt.splitright = true
