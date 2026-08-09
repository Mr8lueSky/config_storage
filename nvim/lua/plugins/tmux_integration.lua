return {
    "christoomey/vim-tmux-navigator",
    cmd = {
        "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp",
        "TmuxNavigateRight", "TmuxNavigatePrevious", "TmuxNavigatorProcessList"
    },
    keys = {
        {"<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>"},
        {"<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>"},
        {"<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>"},
        {"<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>"},
        {"<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>"}
    },
    config = function()
        vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "*",
            callback = function()
                vim.keymap.set('t', '<C-h>', '<C-h>', {buffer = true})
                vim.keymap.set('t', '<C-j>', '<C-j>', {buffer = true})
                vim.keymap.set('t', '<C-k>', '<C-k>', {buffer = true})
                vim.keymap.set('t', '<C-l>', '<C-l>', {buffer = true})
            end
        })
    end
}
