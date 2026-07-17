return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = {
        {"nvim-tree/nvim-web-devicons" , "refractalize/oil-git-status.nvim", opts = {}}
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
                ["<leader>y"] = "actions.copy_entry_path"
            }
        })
    end
}
