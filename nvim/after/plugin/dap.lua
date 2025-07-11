local dap = require('dap')
dap.configurations.python = {
    {
        justMyCode = false,
        type = "python",
        request = "attach",
        name = "attach",
        connect = {host = "127.0.0.1", port = 5678}
    }
}
