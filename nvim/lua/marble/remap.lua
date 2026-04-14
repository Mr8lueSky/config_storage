vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-q>", function() vim.cmd(":q") end)
vim.keymap.set("n", "<leader>dd", '"_dd')

-- ctrl + backspace in insert mode to delete whole words
vim.keymap.set('i', '<C-H>', '<C-W>', {noremap = true})
vim.keymap.set('i', '<C-BS>', '<C-W>', {noremap = true})

-- move between windows
vim.cmd("nnoremap <C-h> <C-w>h")
vim.cmd("nnoremap <C-j> <C-w>j")
vim.cmd("nnoremap <C-k> <C-w>k")
vim.cmd("nnoremap <C-l> <C-w>l")

-- jk to enter normal mode from insert
vim.keymap.set('i', 'jk', '<Esc>', {noremap = true})

-- paste without yanking
vim.cmd('vnoremap <leader>o "_dp')

-- Exit terminal on ctrl + x
vim.cmd(":tnoremap <C-x> <C-\\><C-n>")

-- Open horizontal terminal on space + t + h
vim.keymap.set("n", "<leader>th", function()
    local win_id = vim.api.nvim_get_current_win();
    vim.cmd(":split")
    vim.api.nvim_set_current_win(win_id)
    vim.cmd(":terminal")
    vim.api.nvim_win_set_height(win_id, 15)
end)
vim.keymap.set("n", "<leader>tv", function()
    local win_id = vim.api.nvim_get_current_win();
    vim.cmd(":vsplit")
    vim.api.nvim_set_current_win(win_id)
    vim.cmd(":terminal")
end)

-- Execute cmd in vertical terminal on space + t + e
vim.keymap.set("n", "<leader>te", function()
    local win_id = vim.api.nvim_get_current_win();
    local cmd = vim.fn.input("Cmd: ", "", "shellcmd");
    local cmd_vim = string.format(":terminal %s", cmd);
    vim.cmd(":vsplit")
    vim.api.nvim_set_current_win(win_id)
    vim.cmd(cmd_vim)
end)

-- Resize windows on ctrl + alt + hkjl
vim.keymap.set("n", "<C-M-J>", function() vim.cmd(":resize -5") end)
vim.keymap.set("n", "<C-M-K>", function() vim.cmd(":resize +5") end)
vim.keymap.set("n", "<C-M-L>", function() vim.cmd(":vertical resize +5") end)
vim.keymap.set("n", "<C-M-H>", function() vim.cmd(":vertical resize -5") end)

-- Open diagnostic message on [] - o
local open_diagnostic = function()
    vim.diagnostic.open_float()
    vim.diagnostic.open_float()
end
vim.keymap.set("n", "[o", open_diagnostic)
vim.keymap.set("n", "]o", open_diagnostic)

-- Show diagnostic messages in quickfix menu for current file
vim.keymap.set("n", "[re", function()
    vim.diagnostic.setloclist({severity = vim.diagnostic.severity.ERROR})
end)
vim.keymap.set("n", "]re", function()
    vim.diagnostic.setloclist({severity = vim.diagnostic.severity.ERROR})
end)

vim.keymap.set("n", "[rd", vim.diagnostic.setloclist)
vim.keymap.set("n", "]rd", vim.diagnostic.setloclist)

-- Code actions
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

-- Line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        if vim.bo.buflisted then
            vim.opt_local.number = true
            vim.opt_local.relativenumber = true
        end
    end
})
