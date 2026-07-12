local oil = require("oil")

oil.setup({
    win_options = {signcolumn = "yes:2"},
    keymaps = {
        ["<C-l>"] = false,
        ["<C-r>"] = "actions.refresh",
        ["<leader>y"] = "actions.copy_entry_path"
    }
})
