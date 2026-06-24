require("neotest").setup({
    adapters = {
        require("neotest-python")({
            dap = {justMyCode = false},
            args = {"--log-level", "DEBUG", "-n", "logical", "--alluredir", "allure", "--clean-alluredir"},
            runner = "pytest"
        })
    }
})

vim.keymap.set("n", "<leader>ts", ":Neotest summary\r\n")
vim.keymap.set("n", "<leader>tr", ":Neotest run\r\n")
vim.keymap.set("n", "<leader>tn", ":Neotest jump next\r\n")
vim.keymap.set("n", "<leader>tp", ":Neotest jump prev\r\n")
