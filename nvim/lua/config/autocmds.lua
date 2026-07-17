-- Terminal background follows colorscheme
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
    callback = function()
        local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        if not normal.bg then return end
        io.write(string.format("\027]11;#%06x\027\\", normal.bg))
    end,
})

vim.api.nvim_create_autocmd("UILeave", {
    callback = function() io.write("\027]111\027\\") end,
})

-- Line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        if vim.bo.buflisted then
            vim.opt_local.number = true
            vim.opt_local.relativenumber = true
        end
    end,
})