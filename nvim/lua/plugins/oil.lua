return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = {
        {
            "nvim-tree/nvim-web-devicons",
            "refractalize/oil-git-status.nvim",
            opts = {}
        }
    },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
        local oil = require("oil")
        oil.setup({
            win_options = {signcolumn = "yes:2"},
            keymaps = {
                ["<C-l>"] = false,
                ["<C-h>"] = false,
                ["<C-r>"] = "actions.refresh",
                ["<C-a>"] = {"actions.select", opts = {horizontal = true}},
                ["<leader>p"] = "actions.copy_entry_path",
                ["<leader>n"] = "actions.copy_entry_filename",
            }
        })

        vim.api.nvim_create_user_command("FindFile", function(opts)
            local full_path = vim.fn.expand(opts.args)
            require("oil").open(full_path, nil)
            vim.cmd(":Oil")
        end, {
            nargs = 1,
            complete = "file"
        })

    vim.keymap.set("n", "<leader>ff", function()
        local path = vim.fn.input("FindFile: ", "~/", "file")
        if path ~= "" then
            vim.cmd("FindFile " .. path)
        end
    end)

    vim.keymap.set("n", "<leader>fr", function() vim.cmd("!echo % | pbcopy") end)

    end
}
