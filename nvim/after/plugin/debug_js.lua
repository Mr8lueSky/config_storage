local dap = require("dap")

-- Point to vscode-js-debug
local js_debug_path = vim.fn.expand(
                          "$HOME/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js")

-- Setup the adapter
dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {command = "node", args = {js_debug_path, "${port}"}}
}

-- Debug configurations for JS/TS
local js_filetypes = {
    "typescript", "javascript", "typescriptreact", "javascriptreact"
}
for _, ft in ipairs(js_filetypes) do
    dap.configurations[ft] = {
        -- Attach to running Node.js process
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}"
        }, {
            type = "pwa-node",
            request = "attach",
            name = "Attach to Node.js",
            port = 9229,
            address = "localhost",
            localRoot = vim.fn.getcwd(),
            remoteRoot = "/usr/src/app",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = "inspector"
        }
    }
end
