-- https://github.com/sbdchd/neoformat
vim.keymap.set("n", "<leader>f", function()
	vim.cmd(":Neoformat")
end)

vim.cmd([[
	" let g:neoformat_python_ruffcheck = {
 "            \ 'exe': 'ruff',
 "            \ 'args': ['check', '--fix'],
 "            \ 'replace': 0, 
 "            \ 'stdin': 0, 
 "            \ 'valid_exit_codes': [0],
 "            \ }
	
	" let g:neoformat_html_htmlbeautify = {
 "            \ 'exe': 'html-beautify',
 "            \ 'args': ['--indent-size ' .shiftwidth()],
 "            \ 'stdin': 1,
	"     \ 'replace': 1,
 "            \ }
	let g:neoformat_run_all_formatters = 1
	let g:neoformat_enabled_python = ["ruff", "isort"]
	let g:neoformat_enabled_javascript = ["jsbeautify"]
	let g:neoformat_enabled_css = ["cssbeautify"]
	let g:neoformat_enabled_html = ["htmlbeautify"]
		]])
