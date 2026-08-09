-- File explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Oil)

-- Save / quit
vim.keymap.set("n", "<C-q>", function() vim.cmd(":q") end)
vim.keymap.set("n", "<C-e>", function() vim.cmd(":w") end)

-- Delete without yanking
vim.keymap.set("n", "<leader>dd", '"_dd')

-- Ctrl + backspace in insert mode to delete whole words
vim.keymap.set("i", "<C-H>", "<C-W>", { noremap = true })
vim.keymap.set("i", "<C-BS>", "<C-W>", { noremap = true })

-- Move between windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- jk to enter normal mode from insert
vim.keymap.set("i", "jk", "<Esc>", { noremap = true })

-- Exit terminal on ctrl + x
vim.keymap.set("t", "<C-x>", "<C-\\><C-n>")

-- Open horizontal terminal on <leader>th
vim.keymap.set("n", "<leader>th", function()
    local win_id = vim.api.nvim_get_current_win()
    vim.cmd(":split")
    vim.api.nvim_set_current_win(win_id)
    vim.cmd(":terminal")
    vim.api.nvim_win_set_height(win_id, 15)
end)

-- Open vertical terminal on <leader>tv
vim.keymap.set("n", "<leader>tv", function()
    local win_id = vim.api.nvim_get_current_win()
    vim.cmd(":vsplit")
    vim.api.nvim_set_current_win(win_id)
    vim.cmd(":terminal")
end)

-- Execute cmd in vertical terminal on <leader>te
vim.keymap.set("n", "<leader>te", function()
    local win_id = vim.api.nvim_get_current_win()
    local cmd = vim.fn.input("Cmd: ", "", "shellcmd")
    local cmd_vim = string.format(":terminal %s", cmd)
    vim.cmd(":vsplit")
    vim.api.nvim_set_current_win(win_id)
    vim.cmd(cmd_vim)
end)

-- Resize windows on ctrl + alt + hkjl
vim.keymap.set("n", "<C-M-J>", function() vim.cmd(":resize -5") end)
vim.keymap.set("n", "<C-M-K>", function() vim.cmd(":resize +5") end)
vim.keymap.set("n", "<C-M-L>", function() vim.cmd(":vertical resize +5") end)
vim.keymap.set("n", "<C-M-H>", function() vim.cmd(":vertical resize -5") end)

-- Open diagnostic message
local open_diagnostic = function()
    vim.diagnostic.open_float()
    vim.diagnostic.open_float()
end
vim.keymap.set("n", "[o", open_diagnostic)
vim.keymap.set("n", "]o", open_diagnostic)

-- Show diagnostic errors in location list
vim.keymap.set("n", "[re", function()
    vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set("n", "]re", function()
    vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.ERROR })
end)

-- Code actions
vim.keymap.set("n", ".g", vim.lsp.buf.code_action)


-- Toggle diagnostic virtual text
vim.keymap.set("n", "<leader>ie", function()
    local config = vim.diagnostic.config() or {}
    local virt_text = config.virtual_text
    vim.diagnostic.config({ virtual_text = not virt_text })
end, { desc = "Toggle diagnostic virtual text" })

-- Toggle inlay hints
vim.keymap.set("n", "<leader>ih", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
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

vim.keymap.set("n", "[g", function()
    vim.diagnostic.jump({count = -1, wrap = true})
end)

vim.keymap.set("n", "]g", function()
    vim.diagnostic.jump({count = 1, wrap = true})
end)

-- Show diagnostic messages
vim.keymap.set("n", "<leader>ls", vim.diagnostic.setloclist)
-- Clear diagnostic
vim.keymap.set("n", "<leader>lc", function()
    vim.fn.setloclist(0, {})
    vim.cmd(":lclose")
end)

-- Next/Previous quick fix
vim.keymap.set("n", "<C-n>", function()
    pcall(vim.cmd, "cnext")
    pcall(vim.cmd, "lne")
end)
vim.keymap.set("n", "<C-p>", function()
    pcall(vim.cmd, "cprevious")
    pcall(vim.cmd, "lp")
end)
