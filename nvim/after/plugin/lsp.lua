-- LSPs
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- vim.lsp.enable("ts_ls")
vim.lsp.config("ts_ls",
    { workspace_required = true, root_markers = { "package.json" } })
vim.lsp.enable("rust_analyzer")

-- Python
vim.lsp.enable("basedpyright")
vim.lsp.config('basedpyright', {
    root_markers = {
        "pyproject.toml", "setup.py", "setup.cfg", ".git", ".venv", "venv"
    }
    -- settings = {
    --     basedpyright = {
    --         analysis = {configFilePath = "~/projects/manual_per_services/base/pyrightconfig.json"}
    --     }
    -- }
    -- capabilities = {
    --     textDocument = {
    --         completion = false,
    --         hover = false,
    --         signatureHelp = false,
    --         definition = false,
    --  definitionProvider = false,
    --         references = false,
    --         documentHighlight = false,
    --         rename = false,
    --         formatting = false,
    --         rangeFormatting = false
    --     }
    -- },
    -- handlers = {
    --        ['textDocument/publishDiagnostics'] = function() end, -- disable diagnostics
    -- ["textDocument/definition"] = function() end,
    -- }
})

-- vim.lsp.enable("ty")
-- vim.lsp.enable("ruff")
-- vim.lsp.config('ruff', {
--   init_options = {
--     settings = {
--       configuration = vim.fn.expand('~/.ruff_config'),
--       configurationPreference = "filesystemFirst",
--     }
--   }
-- })

vim.lsp.inlay_hint.enable()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Keybinds
vim.diagnostic.config({ jump = { float = true } })

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

vim.keymap.set("n", "[g",
    function() vim.diagnostic.jump({ count = -1, wrap = true }) end)

vim.keymap.set("n", "]g",
    function() vim.diagnostic.jump({ count = 1, wrap = true }) end)

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

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
