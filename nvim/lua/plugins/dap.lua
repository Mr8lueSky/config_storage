return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "mfussenegger/nvim-dap-python",
        "HiPhish/debugpy.nvim",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- DAP UI
        dapui.setup({
            controls = {
                element = "repl",
                enabled = true,
                icons = {
                    disconnect = "",
                    pause = "",
                    play = "",
                    run_last = "",
                    step_back = "",
                    step_into = "",
                    step_out = "",
                    step_over = "",
                    terminate = "",
                },
            },
            element_mappings = {},
            expand_lines = true,
            floating = {
                border = "single",
                mappings = { close = { "q", "<Esc>" } },
            },
            force_buffers = true,
            icons = {
                collapsed = "",
                current_frame = "",
                expanded = "",
            },
            layouts = {
                {
                    elements = {
                        { id = "scopes", size = 0.33 },
                        { id = "breakpoints", size = 0.33 },
                        { id = "stacks", size = 0.33 },
                    },
                    position = "left",
                    size = 10,
                },
                {
                    elements = { { id = "repl", size = 0.85 } },
                    position = "bottom",
                    size = 10,
                },
            },
            mappings = {
                edit = "e",
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                repl = "r",
                toggle = "t",
            },
            render = { indent = 1, max_value_lines = 100 },
        })

        require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")

        -- Python config
        dap.configurations.python = {
            {
                justMyCode = false,
                type = "python",
                request = "attach",
                name = "attach",
                connect = { host = "127.0.0.1", port = 5678 },
            },
        }

        -- C# / .NET
        dap.adapters.coreclr = {
            type = "executable",
            command = "/usr/local/netcoredbg",
            args = { "--interpreter=vscode" },
        }

        dap.configurations.cs = {
            {
                type = "coreclr",
                name = "launch - netcoredbg",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
                end,
            },
        }

        -- Auto open/close UI
        dap.listeners.before.attach.dapui_config = function() dapui.open() end
        dap.listeners.before.launch.dapui_config = function() dapui.open() end
        dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
        dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

        -- Keymaps
        vim.keymap.set("n", "<leader>dt", function() require("dapui").toggle() end)
        vim.keymap.set("n", "<leader>da", function() require("dap").toggle_breakpoint() end)
        vim.keymap.set("n", "<leader>ds", function() require("dap").step_over() end)
        vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end)
        vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end)
    end,
}