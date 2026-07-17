return {
    'mbbill/undotree',
    branch = 'master',
    lazy = false,
    config = function()
        vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
        vim.keymap.set('n', '<leader>U', vim.cmd.UndotreeFocus)
    end
}
