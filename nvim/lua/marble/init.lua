require("marble.autocomplete")
require("marble.remap")
require("marble.fixes")
require("marble.helpers")
require("marble.keymaps")

vim.cmd("set rnu")
vim.cmd("set number")
vim.cmd("setlocal spell spelllang=en_us,ru")
vim.o.clipboard = "unnamedplus"

-- allow netrw to copy files to same directory 
-- vim.o.exrc = true
vim.cmd [[
	" let g:netrw_keepdir=1
	let g:netrw_bufsettings="rnu"
]]
vim.opt.exrc = true
vim.o.winborder = "rounded"

vim.keymap.set('n', '<leader>ie', function()
    local config = vim.diagnostic.config() or {}
    local virt_text = config.virtual_text
    vim.diagnostic.config({virtual_text = not virt_text})
end, {desc = "Toggle diagnostic virtual text"})

-- set environment variables
local env_var_names = {"SERVICE_VERSION", "UPSTREAM_CI_COMMIT_REF_SLUG"}

vim.keymap.set('n', '<leader>es', function()
    local set_with_value = function(to_set)
        vim.ui.input({prompt = "ENV value: "}, function(value)
            vim.cmd(":let $" .. to_set .. "=\"" .. value .. "\"")
        end)
    end

    vim.ui.select(env_var_names, {}, function(key)
        if key == nil then
            vim.ui.input({prompt = "ENV key: "}, set_with_value)
        else
            set_with_value(key)
        end
    end)
end)

vim.keymap.set('n', '<leader>ec', function()
    local print_value = function(to_print)
        vim.cmd(":!echo $" .. to_print )
    end

    vim.ui.select(env_var_names, {}, function(key)
        if key == nil then
            vim.ui.input({prompt = "ENV key: "}, print_value)
        else
            print_value(key)
        end
    end)
end)

