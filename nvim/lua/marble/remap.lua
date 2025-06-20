vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-q>", function()
	vim.cmd(":q")
end)
vim.keymap.set("n", "<leader>dd", '"_dd')

-- ctrl + backspace in insert mode to delete whole words
vim.keymap.set('i', '<C-H>', '<C-W>', {noremap = true})
vim.keymap.set('i', '<C-BS>', '<C-W>', {noremap = true})

-- move between windows
vim.cmd("nnoremap <M-h> <C-w>h")
vim.cmd("nnoremap <M-j> <C-w>j")
vim.cmd("nnoremap <M-k> <C-w>k")
vim.cmd("nnoremap <M-l> <C-w>l")

-- jk to enter visual mode from insert
vim.keymap.set('i', 'jk', '<Esc>', {noremap = true})

-- ctrl + k and ctrl + j to page up/down
vim.cmd("nnoremap <C-j> <PageDown>")
vim.cmd("nnoremap <C-k> <PageUp>")

-- paste without yanking
vim.cmd('vnoremap <leader>o "_dp')
