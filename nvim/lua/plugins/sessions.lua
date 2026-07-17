return {
    "rmagatti/auto-session",
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        suppressed_dirs = {"~/", "~/Projects", "~/Downloads", "/"},
        close_filetypes_on_save = {"terminal"}

        -- log_level = 'debug',
        --    preserve_buffer_on_restor = function(bufnr)
        --        local buffer_name = vim.api.nvim_buf_get_name(bufnr)
        -- print("I'm working!")
        --        return buffer_name ~= nil
        --    end
    },
    config = function()
        require('auto-session').setup({
            pre_save_cmds = {
                -- Automatically close all Oil buffers before saving the session
                function()
                    for _, win in pairs(vim.api.nvim_list_wins()) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        if vim.bo[buf].filetype == 'oil' then
                            vim.api.nvim_win_close(win, true)
                        end
                    end
                end
            }
        })
        vim.o.sessionoptions =
            "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end
}
