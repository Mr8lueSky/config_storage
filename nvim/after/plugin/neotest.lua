local neotest = require("neotest")

DEFAULT_NEOTEST_CONFIG = {
    adapters = {
        require("neotest-python")({
            dap = {justMyCode = false},
            args = {
                "--log-level", "DEBUG", "-n", "logical", "--alluredir",
                "allure", "--clean-alluredir"
            },
            runner = "pytest",
        })
    },
    quickfix = {enabled = true, open = false},
    status = {virtual_text = true, signs = false}
}

neotest.setup(DEFAULT_NEOTEST_CONFIG)

vim.keymap.set("n", "<leader>ts", ":Neotest summary\r\n")
vim.keymap.set("n", "<leader>tr", ":Neotest run\r\n")
vim.keymap.set("n", "<leader>tn", ":Neotest jump next\r\n")
vim.keymap.set("n", "<leader>tp", ":Neotest jump prev\r\n")
vim.keymap.set("n", "<leader>to", ":Neotest output-panel\r\n")

local allure_job_id = nil;

vim.keymap.set("n", "<leader>as", function()
    if allure_job_id ~= nil then vim.fn.jobstop(allure_job_id) end
    allure_job_id = vim.fn.jobstart("allure serve allure")
end)

