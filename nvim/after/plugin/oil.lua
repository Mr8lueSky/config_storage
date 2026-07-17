local oil = require("oil")

oil.setup({
    win_options = {signcolumn = "yes:2"},
    keymaps = {
        ["<C-l>"] = false,
        ["<C-h>"] = false,
        ["<C-r>"] = "actions.refresh",
        ["<C-a>"] ={ "actions.select", opts = { horizontal = true } },
        ["<leader>y"] = "actions.copy_entry_path",
    }
})
