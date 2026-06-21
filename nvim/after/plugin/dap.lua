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

-- 1. Map the coreclr adapter to netcoredbg
dap.adapters.coreclr = {
  type = 'executable',
  -- Update this path if netcoredbg is installed elsewhere
  command = "/usr/local/netcoredbg",
  args = {'--interpreter=vscode'}
}

-- 2. Configure debugging sessions for C#
dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    -- Dynamically finds the compiled DLL file
    program = function()
        return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}

