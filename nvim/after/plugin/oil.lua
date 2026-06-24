local oil = require("oil")

oil.setup({win_options = {signcolumn = "yes:2"}})
-- Copy absolute path of the file under the cursor
vim.keymap.set("n", "<leader>y", function()
    local dir = oil.get_current_dir()
    local entry = oil.get_cursor_entry()
    if dir and entry then
        local full_path = dir .. entry.name
        vim.fn.setreg("+", full_path) -- Copies to clipboard
        vim.notify("Copied: " .. full_path)
    end
end, {desc = "Copy absolute filepath to clipboard", buffer = true})
