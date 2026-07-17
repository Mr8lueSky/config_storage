return {
    'sbdchd/neoformat',
    config = function()
        -- https://github.com/sbdchd/neoformat
        vim.keymap.set("n", "<leader>f", function() vim.cmd(":Neoformat") end)
        vim.g.neoformat_python_isort = {args = {'--multi-line', 3}}
        vim.cmd([[
            let g:neoformat_run_all_formatters = 1
            let g:neoformat_enabled_python = ["ruff", "isort"]
            let g:neoformat_enabled_javascript = ["jsbeautify"]
            let g:neoformat_enabled_css = ["cssbeautify"]
            let g:neoformat_enabled_html = ["htmlbeautify"]
        ]])
    end
}
