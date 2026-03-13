require("neotest").setup({
    adapters = {
        require("neotest-python")({
            dap = {justMyCode = false},
            args = {"--log-level", "DEBUG"},
            runner = "pytest",
	    python = {"venv/bin/python"}
        })
    }
})

vim.keymap.set("n", "<leader>ts", ":Neotest summary\r\n")
vim.keymap.set("n", "<leader>tr", ":Neotest run\r\n")
